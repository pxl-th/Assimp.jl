"""
Returns:
      0 -- no embedded texture
    ≥ 1 -- embedded texture stored in scene.mTextures
"""
function find_embedded_texture(scene::aiScene, texture_name::String)::Int64
    for i in 1:scene.mNumTextures
        texture_ptr = unsafe_load(scene.mTextures, i)
        raw_texture = unsafe_load(texture_ptr)
        texture_file = to_string(raw_texture.mFilename)
        texture_file == texture_name && return i
    end
    0
end
function get_embedded_texture(scene::aiScene, id)::aiTexture
    id ∉ 1:scene.mNumTextures && error(
        "Scene has textures under [1:$(scene.mNumTextures)] ids, but given id is [$id].")
    unsafe_load(scene.mTextures, id) |> unsafe_load
end

function load_embedded_texture(data::Ptr{aiTexel}, bytes::UInt32)
    texels_num = Int(ceil(bytes / 4))
    texture_bytes = Vector{UInt8}(undef, 4 * texels_num)
    byte_id = 1
    for i in 1:texels_num
        texel = unsafe_load(data, i)
        texture_bytes[byte_id] = texel.b; byte_id += 1
        texture_bytes[byte_id] = texel.g; byte_id += 1
        texture_bytes[byte_id] = texel.r; byte_id += 1
        texture_bytes[byte_id] = texel.a; byte_id += 1
    end
    ImageMagick.load_(texture_bytes[1:bytes])
end

function load_embedded_texture(data::Ptr{aiTexel}, width::UInt32, height::UInt32)
    texture = Array{ColorTypes.RGBA, 2}(undef, width, height)
    texel_id = 1
    for i in 1:width, j in 1:height
        ai_texel = unsafe_load(data, texel_id); texel_id += 1
        texture[i, j] = ColorTypes.RGBA(ai_texel.b, ai_texel.g, ai_texel.r, ai_texel.a)
        # texture[i, j] = ColorTypes.RGBA(ai_texel.r, ai_texel.g, ai_texel.b, ai_texel.a)
    end
    texture
end

function load_texture(ai_texture::aiTexture)
    ai_texture.mHeight == 0 &&
        return load_embedded_texture(ai_texture.pcData, ai_texture.mWidth)
    load_embedded_texture(ai_texture.pcData, ai_texture.mWidth, ai_texture.mHeight)
end

function load_texture(
    scene::aiScene, embedded::Int64, texture_file::String, model_dir::String,
)
    if embedded == 0
        path = joinpath(model_dir, texture_file)
        !isfile(path) && error("Texture [$path] does not exist.")
        return FileIO.load(path)
    else
        return get_embedded_texture(scene, embedded) |> load_texture
    end
end

function process_texture(
    scene::aiScene, type::aiTextureType, material_ptr::Ptr{aiMaterial},
    model_dir::String,
)::Vector{Texture}
    textures = Texture[]

    count = aiGetMaterialTextureCount(material_ptr, type)
    count == 0 && return textures
    tmp_path = aiString[aiString(0, tuple(zeros(UInt8, 1024)...))]

    for i in 1:count
        result = aiGetMaterialTexture(
            material_ptr, type, UInt32(i - 1), pointer(tmp_path),
            C_NULL, C_NULL, C_NULL, C_NULL, C_NULL, C_NULL)
        if result == AI_FAILURE
            println("Failed to get material texture, skipping this type.")
            break
        end

        texture_file = to_string(tmp_path[1])
        embedded = find_embedded_texture(scene, texture_file)
        texture_data = load_texture(scene, embedded, texture_file, model_dir)
        push!(textures, Texture(type, embedded, texture_file, texture_data))
    end
    textures
end

function process_materials(scene::aiScene, model_dir::String)
    tmp_color = aiColor4D[aiColor4D(0, 0, 0, 0)]
    tmp_float = Float32[0]

    materials = Dict{UInt32, Material}()
    for i in 1:scene.mNumMaterials
        material_ptr = unsafe_load(scene.mMaterials, i)
        textures = Dict{aiTextureType, Vector{Texture}}()
        colors = Dict{Symbol, aiColor4D}()
        scalars = Dict{Symbol, Float32}()

        for type in TEXTURE_TYPES
            type_textures = process_texture(scene, type, material_ptr, model_dir)
            !isempty(type_textures) && (textures[type] = type_textures)
        end
        for type in COLOR_TYPES
            result = aiGetMaterialColor(
                material_ptr, "\$clr.$type", 0, 0, pointer(tmp_color))
            result == AI_SUCCESS && (colors[type] = tmp_color[1])
        end
        for type in MATERIAL_SCALARS
            result = aiGetMaterialFloatArray(
                material_ptr, "\$mat.$type", 0, 0, pointer(tmp_float), C_NULL)
            result == AI_SUCCESS && (scalars[type] = tmp_float[1])
        end

        materials[i] = Material(;textures=textures, colors..., scalars...)
    end
    materials
end
