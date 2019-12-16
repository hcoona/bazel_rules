load("//native_tools:native_tools_toolchain.bzl", "access_tool")

def _flex_library_impl(ctx):
    flex_compiler_data = _get_flex_compiler(ctx)
    lex_output_file = ctx.outputs.out

    ctx.actions.run_shell(
        inputs = [ctx.file.src],
        outputs = [lex_output_file],
        command = "'%s' -o '%s' '%s'" %
                  (
                      flex_compiler_data.path,
                      lex_output_file.path,
                      ctx.file.src.path,
                  ),
        progress_message = "Flex generating...",
        mnemonic = "GenFlex",
    )

    return [DefaultInfo(files = depset([lex_output_file]))]

flex_library = rule(
    implementation = _flex_library_impl,
    attrs = {
        "src": attr.label(
            mandatory = True,
            allow_single_file = [".l", ".ll", ".lex"],
            doc = "Lex source file.",
        ),
        "out": attr.output(
            mandatory = True,
            doc = "Lex generated file.",
        ),
    },
    toolchains = ["//rules_flex:toolchain_type"],
)

def _get_flex_compiler(ctx):
    return access_tool("//rules_flex:toolchain_type", ctx, "flex")
