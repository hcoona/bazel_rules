workspace(name = "com_github_hcoona_bazel_rules")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

register_toolchains(
    "//rules_thrift:preinstalled_thrift_compiler_toolchain",
)

register_toolchains(
    "//rules_flex:preinstalled_flex_compiler_toolchain",
    "//rules_bison:preinstalled_bison_compiler_toolchain",
)

register_toolchains(
    "//rules_bar:barc_linux_toolchain",
)
