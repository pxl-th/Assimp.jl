struct Texture
    """
      0 -- means texture is not embedded
    ≥ 1 -- texture is embedded and located in [scene.mTextures] array
    """
    type::aiTextureType
    embedded::Int64
    file::String
    data::Array
end

@with_kw struct Material
    ambient::aiColor4D = aiColor4D(0, 0, 0, 0)
    diffuse::aiColor4D = aiColor4D(0, 0, 0, 0)
    specular::aiColor4D = aiColor4D(0, 0, 0, 0)
    emissive::aiColor4D = aiColor4D(0, 0, 0, 0)

    textures::Dict{aiTextureType, Vector{Texture}} # texture type => [Texture]

    shininess::Float32 = 0f0
    shinpercent::Float32 = 0f0
    opacity::Float32 = 0f0
    transparencyfactor::Float32 = 0f0
    reflectivity::Float32 = 0f0
    refracti::Float32 = 0f0
    bumpscaling::Float32 = 0f0
end

struct MetaMesh
    mesh::GeometryBasics.Mesh
    material_idx::Int64
    tangents::Union{Vector{Vec3f0}, Missing}
    bitangents::Union{Vector{Vec3f0}, Missing}
end

struct Node
    meshes::Vector{MetaMesh}
    children::Vector{Node}
end

struct Scene
    node::Node
    materials::Dict{UInt32, Material}
    path::String
end
