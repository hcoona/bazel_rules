load("//native_tools:native_tools_toolchain.bzl", "access_tool")

def _change_file_extension(filename, extension):
    return filename.rsplit(".", 1)[0] + extension

def _bison_library_impl(ctx):
    bison_compiler_data = _get_bison_compiler(ctx)

    yacc_output_file = ctx.outputs.out
    output_files = [yacc_output_file]
    commands = [bison_compiler_data.path, "-o", yacc_output_file.path]

    if ctx.attr.gen_posix_header:
        commands.append("-d")
        yacc_header_output_file = ctx.actions.declare_file(
            _change_file_extension(yacc_output_file.basename, ".hh"),
            sibling = yacc_output_file,
        )
        output_files.append(yacc_header_output_file)

    commands.append(ctx.file.src.path)
    cmd = " ".join(commands)

    ctx.actions.run_shell(
        inputs = [ctx.file.src],
        outputs = output_files,
        command = cmd,
        progress_message = "bison generating...",
        mnemonic = "GenBison",
    )

    return [DefaultInfo(files = depset(output_files))]

bison_library = rule(
    implementation = _bison_library_impl,
    attrs = {
        "src": attr.label(
            mandatory = True,
            allow_single_file = [".y", ".yy", ".yacc"],
            doc = "Yacc source file.",
        ),
        "out": attr.output(
            mandatory = True,
            doc = "Yacc generated file.",
        ),
        "gen_posix_header": attr.bool(
            default = False,
            doc = "also produce a header file, but cannot specify FILE (for POSIX Yacc)",
        ),
    },
    toolchains = ["//rules_bison:toolchain_type"],
)

def _get_bison_compiler(ctx):
    return access_tool("//rules_bison:toolchain_type", ctx, "bison")
