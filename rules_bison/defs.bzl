load("//native_tools:native_tools_toolchain.bzl", "access_tool")

def _bison_library_impl(ctx):
    bison_compiler_data = _get_bison_compiler(ctx)
    lex_output_file = ctx.outputs.out

    ctx.actions.run_shell(
        inputs = [ctx.file.src],
        outputs = [lex_output_file],
        command = "'%s' -o '%s' '%s'" %
                  (
                      bison_compiler_data.path,
                      lex_output_file.path,
                      ctx.file.src.path,
                  ),
        progress_message = "bison generating...",
        mnemonic = "Genbison",
    )

    return [DefaultInfo(files = depset([lex_output_file]))]

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
    },
    toolchains = ["//rules_bison:toolchain_type"],
)

def _get_bison_compiler(ctx):
    return access_tool("//rules_bison:toolchain_type", ctx, "bison")
