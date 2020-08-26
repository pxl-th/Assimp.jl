# Assimp

[Assimp](https://github.com/assimp/assimp) wrapper for Julia.

Also provides convenient way to load & convert data to Julia-native format.
To load model & convert it into Julia-native data, use `Assimp.load` function:

```julia
using Assimp
scene::Assimp.Scene = Assimp.load("./model.obj", aiProcess_JoinIdenticalVertices)
```

Flags below are always used:

- `aiProcess_SortByPType` -- to sort/split meshes by their primitive type
- `aiProcess_ValidateDataStructure`

By default, loader also adds following flags:

- `aiProcess_Triangulate`
- `aiProcess_GenSmoothNormals`
- `aiProcess_CalcTangentSpace`

which can be disabled, by setting `default_flags` keyword argument to `fasle`.

## Features

- Support for both regular and embedded textures (loads them into Julia's `Array`).
- Loaded meshes are converted into [GeometryBasics.jl](https://github.com/JuliaGeometry/GeometryBasics.jl) meshes,
with additional info, like tangents, stored in `Assimp.MetaMesh` alongside with `GeometryBasics.Mesh`.
