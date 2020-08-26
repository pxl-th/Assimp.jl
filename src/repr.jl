function Base.show(io::IO, texture::Texture)
    print(io, "[Texture]\n",
        " - type: ", texture.type, '\n',
        " - embedded [", texture.embedded != 0, "]: ", texture.embedded, '\n',
        " - file: ", texture.file, '\n',
        " - size: ", size(texture.data), '\n',
        " - eltype: ", eltype(texture.data), '\n',
    )
end

function Base.show(io::IO, material::Material)
    print(io, "[Material]\n",
        " - ambient: ", material.ambient, '\n',
        " - diffuse: ", material.diffuse, '\n',
        " - specular: ", material.specular, '\n',
        " - emissive: ", material.emissive, '\n',
        " - shininess: ", material.shininess, '\n',
        " - shinpercent: ", material.shinpercent, '\n',
        " - opacity: ", material.opacity, '\n',
        " - transparencyfactor: ", material.transparencyfactor, '\n',
        " - reflectivity: ", material.reflectivity, '\n',
        " - refracti: ", material.refracti, '\n',
        " - bumpscaling: ", material.bumpscaling, '\n',
        " - texture types [", length(material.textures), "]:\n",
    )
    for (type, textures) in material.textures
        print(io, type, " [", length(textures), "]: \n")
        for (i, texture) in enumerate(textures)
            texture_repr = split(repr(texture), '\n'; keepempty=false)
            print(io, "\t[", i, "]: ", texture_repr[1], '\n')
            map(r -> print(io, '\t', r, '\n'), texture_repr[2:end])
        end
    end
    print(io, '\n')
end

function Base.show(io::IO, mesh::MetaMesh)
    print(io, "[MetaMesh]\n",
        " - material idx: ", mesh.material_idx, '\n',
        " - vertices: ", length(coordinates(mesh.mesh)), '\n',
        " - attributes: ", propertynames(mesh.mesh), '\n',
    )
end

function Base.show(io::IO, node::Node, level = 0)
    shift = repeat('\t', level) * '|'

    print(io, "[Node]\n", shift, " - meshes [", length(node.meshes), "]:\n")
    for (i, mesh) in enumerate(node.meshes)
        mesh_repr = split(repr(mesh), '\n'; keepempty=false)
        print(io, shift, '[', i, "]: ", mesh_repr[1], '\n')
        map(r -> print(io, shift, r, '\n'), mesh_repr[2:end])
    end
    println(io, shift, "----------------")
    print(io, shift, " - children [", length(node.children), "]:\n")
    for (i, child) in enumerate(node.children)
        print(io, shift, '[', i, "]: ")
        Base.show(io, child, level + 1)
    end
end
