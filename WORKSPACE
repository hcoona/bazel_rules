workspace(name = "com_github_hcoona_bazel_rules")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

register_toolchains(
    # "//rules_thrift:preinstalled_thrift_compiler_toolchain",
    "//rules_thrift:built_thrift_compiler_toolchain",
)

register_toolchains(
    "//rules_flex:preinstalled_flex_compiler_toolchain",
    "//rules_bison:preinstalled_bison_compiler_toolchain",
)

register_toolchains(
    "//rules_bar:barc_linux_toolchain",
)

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

http_archive(
    name = "com_github_nelhage_rules_boost",
    sha256 = "23030ce74cd02a10df806c5b26c20af38d2ca06e2b2b2af31517f73d8ce63528",
    strip_prefix = "rules_boost-82ae1790cef07f3fd618592ad227fe2d66fe0b31",
    urls = ["https://github.com/nelhage/rules_boost/archive/82ae1790cef07f3fd618592ad227fe2d66fe0b31.zip"],  # Boost 1.68.0
)

load("@com_github_nelhage_rules_boost//:boost/boost.bzl", "boost_deps")

boost_deps()
