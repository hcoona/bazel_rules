load("//native_tools:native_tools_toolchain.bzl", "access_tool")

def _thrift_library_impl(ctx):
    thrift_compiler_data = _get_thrift_compiler(ctx)
    generator_name = ctx.attr.gen
    output_directory = ctx.actions.declare_directory(
        ctx.attr.name + ".gen." + generator_name,
        sibling = ctx.file.src,
    )

    tool = ctx.toolchains["//rules_thrift:toolchain_type"]
    print(tool.data.target)

    ctx.actions.run(
        inputs = [ctx.file.src],
        outputs = [output_directory],
        executable = tool.data.target,
        arguments = [
            "-out",
            output_directory.path,
            "--gen",
            generator_name,
            ctx.file.src.path,
        ],
    )

    # ctx.actions.run_shell(
    #     inputs = [ctx.file.src],
    #     outputs = [output_directory],
    #     command = "echo $PWD && mkdir -p '%s' && '%s' -out '%s' --gen %s '%s' && rm '%s'/*.skeleton.cpp" %
    #               (
    #                   output_directory.path,
    #                   thrift_compiler_data.path,
    #                   output_directory.path,
    #                   generator_name,
    #                   ctx.file.src.path,
    #                   output_directory.path,
    #               ),
    #     progress_message = "Thrift generating %s ..." % generator_name,
    #     mnemonic = "GenThrift",
    # )

    return [DefaultInfo(files = depset([output_directory]))]

thrift_library = rule(
    implementation = _thrift_library_impl,
    attrs = {
        "src": attr.label(
            mandatory = True,
            allow_single_file = [".thrift"],
            doc = "Thrift source file.",
        ),
        "gen": attr.string(
            mandatory = True,
            values = ["cpp", "go", "java", "py"],
            doc = "Thrift generator.",
        ),
    },
    toolchains = ["//rules_thrift:toolchain_type"],
)

def _get_thrift_compiler(ctx):
    return access_tool("//rules_thrift:toolchain_type", ctx, "thrift")
