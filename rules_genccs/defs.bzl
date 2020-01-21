def _impl(ctx):
    tree = ctx.actions.declare_directory(ctx.attr.name + ".cc")

    ctx.actions.run_shell(
        inputs = [],
        outputs = [tree],
        command = "mkdir -p '%s' && echo 'int f1() { return 7; }' > '%s/a.cc' && echo 'int f2() { return 13; }' > '%s/b.cc'" % (
            tree.path,
            tree.path,
            tree.path,
        ),
    )

    return [DefaultInfo(files = depset([tree]))]

genccs = rule(
    implementation = _impl,
)
