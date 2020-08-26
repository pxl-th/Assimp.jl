using Clang
using assimp_win_jll

function Base.islowercase(s::String)::Bool
    mapfoldl(Base.islowercase, (x, y) -> x && y, filter(isletter, s))
end

const ASSIMP_INCLUDE = joinpath(dirname(assimp_win_jll.assimp_path), "..", "include") |> normpath
const ASSIMP_HEADERS = String[
    joinpath(root, file)
    for (root, dirs, files) in walkdir(ASSIMP_INCLUDE) for file in files
    if endswith(file, ".h") && islowercase(file)
]
println.(ASSIMP_HEADERS)

ctx = DefaultContext()
STDLIB = String["-I", raw"C:\Program Files\mingw-w64\x86_64-8.1.0-win32-seh-rt_v6-rev0\mingw64\x86_64-w64-mingw32\include"]
parse_headers!(
    ctx, ASSIMP_HEADERS,
    args=STDLIB, includes=vcat(LLVM_INCLUDE, ASSIMP_INCLUDE),
)

# settings
ctx.libname = "assimp"
ctx.options["is_function_strictly_typed"] = false
ctx.options["is_struct_mutable"] = false

# write output
api_file = joinpath(@__DIR__, "libassimp_win_api.jl")
api_stream = open(api_file, "w")

for trans_unit in ctx.trans_units
    root_cursor = getcursor(trans_unit)
    push!(ctx.cursor_stack, root_cursor)
    header = spelling(root_cursor)
    @info "wrapping header: $header ..."
    # loop over all of the child cursors and wrap them, if appropriate.
    ctx.children = children(root_cursor)
    for (i, child) in enumerate(ctx.children)
        child_name = name(child)
        child_header = filename(child)
        ctx.children_index = i
        # choose which cursor to wrap
        startswith(child_name, "__") && continue  # skip compiler definitions
        child_name in keys(ctx.common_buffer) && continue  # already wrapped
        child_header != header && continue  # skip if cursor filename is not in the headers to be wrapped

        wrap!(ctx, child)
    end
    isempty(ctx.api_buffer) && continue

    @info "writing $(api_file)"
    println(api_stream, "# Julia wrapper for header: $(basename(header))")
    println(api_stream, "# Automatically generated using Clang.jl\n")
    print_buffer(api_stream, ctx.api_buffer)
    empty!(ctx.api_buffer)  # clean up api_buffer for the next header
end
close(api_stream)

# write "common" definitions: types, typealiases, etc.
common_file = joinpath(@__DIR__, "libassimp_win_common.jl")
open(common_file, "w") do f
    println(f, "# Automatically generated using Clang.jl\n")
    print_buffer(f, dump_to_buffer(ctx.common_buffer))
end
