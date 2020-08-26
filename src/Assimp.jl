module Assimp
export load

using assimp_win_jll
using CEnum
using GeometryBasics
using Parameters
import ImageMagick
import FileIO

include(joinpath(@__DIR__, "..", "gen", "libassimp_win_common.jl"))
include(joinpath(@__DIR__, "..", "gen", "libassimp_win_api.jl"))
foreach(names(@__MODULE__, all=true)) do s
    if startswith(string(s), "ai") || startswith(string(s), "AI_")
        @eval export $s
    end
end

# TODO create macro to construct material from these properties
const TEXTURE_TYPES = (
    aiTextureType_DIFFUSE, aiTextureType_SPECULAR, aiTextureType_AMBIENT,
    aiTextureType_SHININESS, aiTextureType_HEIGHT, aiTextureType_NORMALS,
    aiTextureType_DISPLACEMENT, aiTextureType_AMBIENT_OCCLUSION)
const COLOR_TYPES = (:specular, :diffuse, :ambient, :emissive)
const MATERIAL_SCALARS = (
    :shininess, :shinpercent, :opacity, :transparencyfactor,
    :reflectivity, :refracti, :bumpscaling)
const PRIMITIVES = (
    (aiPrimitiveType_POINT, 1), (aiPrimitiveType_LINE, 2),
    (aiPrimitiveType_TRIANGLE, 3))

include("types.jl")
include("repr.jl")
include("materials.jl")

function process_face(face::aiFace)
    indices = [unsafe_load(face.mIndices, i) for i in 1:face.mNumIndices]
    NgonFace{length(indices), UInt32}(indices)
end

to_string(s::aiString)::String = String(UInt8[s.data[1:s.length]...])
to_string(s::NTuple)::String = String(UInt8[s...])

process_uvw(raw::aiVector3D, uvw_type::Type{Vec2f0}) = Vec2f0(raw.x, raw.y)
process_uvw(raw::aiVector3D, uvw_type::Type{Vec3f0}) =
    Vec3f0(raw.x, raw.y, raw.z)

to_vec3f0(raw::aiVector3D) = Vec3f0(raw.x, raw.y, raw.z)
to_point3f0(raw::aiVector3D) = Point3f0(raw.x, raw.y, raw.z)

function process_mesh(raw_mesh::aiMesh)::MetaMesh
    has_uvw = raw_mesh.mTextureCoords[1] != C_NULL
    has_normals = raw_mesh.mNormals != C_NULL
    has_tangents = raw_mesh.mTangents != C_NULL
    has_bitangents = raw_mesh.mBitangents != C_NULL
    has_faces = raw_mesh.mFaces != C_NULL

    uvw_type = raw_mesh.mNumUVComponents[1] == 2 ? Vec2f0 : Vec3f0
    vertices = Vector{Point3f0}(undef, raw_mesh.mNumVertices)
    # Meshes are sorted/split by their primitive type.
    # So each mesh has only one primitive type.
    if has_faces
        face_size = 0
        for (type, vert_num) in PRIMITIVES
            (raw_mesh.mPrimitiveTypes & type != 0) &&
                (face_size = vert_num; break)
        end
        faces = Vector{NgonFace{face_size, UInt32}}(undef, raw_mesh.mNumFaces)
    else
        faces = missing
    end
    normals = has_normals ?
        Vector{Vec3f0}(undef, raw_mesh.mNumVertices) : missing
    uvws = has_uvw ?
        Vector{uvw_type}(undef, raw_mesh.mNumVertices) : missing
    tangents = has_tangents ?
        Vector{Vec3f0}(undef, raw_mesh.mNumVertices) : missing
    bitangents = has_bitangents ?
        Vector{Vec3f0}(undef, raw_mesh.mNumVertices) : missing

    @inbounds for i in 1:raw_mesh.mNumVertices
        vertices[i] = unsafe_load(raw_mesh.mVertices, i) |> to_point3f0
        has_normals && (normals[i] =
            unsafe_load(raw_mesh.mNormals, i) |> to_vec3f0)
        has_uvw && (uvws[i] = process_uvw(
            unsafe_load(raw_mesh.mTextureCoords[1], i), uvw_type))
        has_tangents && (tangents[i] =
            unsafe_load(raw_mesh.mTangents, i) |> to_vec3f0)
        has_bitangents && (bitangents[i] =
            unsafe_load(raw_mesh.mBitangents, i) |> to_vec3f0)
    end

    attributes = Dict{Symbol, Any}()
    has_normals && (attributes[:normals] = normals)
    has_uvw && (attributes[:uvw] = uvws)

    if has_faces
        @inbounds for i in 1:raw_mesh.mNumFaces
            faces[i] = process_face(unsafe_load(raw_mesh.mFaces, i))
        end
        mesh = Mesh(meta(vertices; attributes...), faces)
    else
        mesh = Mesh(meta(vertices; attributes...))
    end

    MetaMesh(mesh, raw_mesh.mMaterialIndex + 1, tangents, bitangents)
end

function process_node(node::aiNode, scene::aiScene)
    meshes = Vector{MetaMesh}(undef, node.mNumMeshes)
    children = Vector{Node}(undef, node.mNumChildren)

    for i in 1:node.mNumMeshes
        mesh_id = unsafe_load(node.mMeshes, i) + 1
        mesh_raw = unsafe_load(scene.mMeshes, mesh_id) |> unsafe_load
        meshes[i] = process_mesh(mesh_raw)
    end
    for i in 1:node.mNumChildren
        child = unsafe_load(node.mChildren, i) |> unsafe_load
        children[i] = process_node(child, scene)
    end

    Node(meshes, children)
end

"""
Two post-process flags are always added:
    - sort/split meshes by their primitive type, to ensure that
    each mesh has only one primitive type;
    - validate data structures.
"""
function load(
    path::String, flags::UInt32 = UInt32(0); default_flags::Bool = true,
)::Scene
    !isfile(path) && error("Given path [$path] does not exist.")
    default_flags && (flags |= (aiProcess_Triangulate
        | aiProcess_GenSmoothNormals
        | aiProcess_CalcTangentSpace))
    flags |= aiProcess_SortByPType | aiProcess_ValidateDataStructure
    # TODO capture assimp log in case of errors

    scene_ptr = aiImportFile(path, flags)
    scene_ptr == C_NULL && error(unsafe_string(aiGetErrorString()))

    raw_scene = unsafe_load(scene_ptr)
    (raw_scene.mRootNode == C_NULL || raw_scene.mFlags & AI_SCENE_FLAGS_INCOMPLETE == 1) &&
        error(unsafe_string(aiGetErrorString()))

    model_dir = dirname(path)
    node = process_node(unsafe_load(raw_scene.mRootNode), raw_scene)
    materials = process_materials(raw_scene, model_dir)
    aiReleaseImport(scene_ptr)
    Scene(node, materials, path)
end

# function main()
#     paths = String[
#         raw"C:\Users\tonys\projects\3d-models\bowl-of-candles\source\Bowl_Candles.fbx",
#         raw"C:\Users\tonys\projects\3d-models\vehicle-renault-12\source\VEHICLE - RENAULT 12.fbx",
#         raw"C:\Users\tonys\projects\3d-models\king\source\King_01.obj",
#         raw"C:\Users\tonys\projects\3d-models\cat\12221_Cat_v1_l3.obj",
#         raw"C:\Users\tonys\projects\3d-models\advanced-primitive\sphere.obj"]
#     flags = aiProcess_JoinIdenticalVertices | aiProcess_ImproveCacheLocality
#     for path in paths
#         println("Loading ", path)
#         model = load(path, flags)
#         println(model)
#         println(repeat('=', 20))
#     end

#     point_clouds = String[
#         raw"C:\Users\tonys\projects\3d-models\rotated_strip_point_cloud\scene.gltf",
#         raw"C:\Users\tonys\projects\3d-models\central_park_hybrid_point_cloud_model\scene.gltf",
#         raw"C:\Users\tonys\projects\3d-models\central_park_bridge_point_cloud\scene.gltf"]
#     println("=== Point cloud loading === ")
#     for path in point_clouds
#         println("Loading ", path)
#         model = load(path; default_flags=false)
#         println(model)
#         println(repeat('=', 20))
#     end
# end
# main()

end
