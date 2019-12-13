workspace(name = "com_github_hcoona_bazel_rules")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

ALL_CONTENT = """filegroup(name = "all", srcs = glob(["**"]), visibility = ["//visibility:public"])"""

######## Skylark libraries ########

http_archive(
    name = "bazel_skylib",
    sha256 = "9245b0549e88e356cd6a25bf79f97aa19332083890b7ac6481a2affb6ada9752",
    strip_prefix = "bazel-skylib-0.9.0",
    url = "https://github.com/bazelbuild/bazel-skylib/archive/0.9.0.tar.gz",  # 2019-07-13
)

http_archive(
    name = "rules_foreign_cc",
    sha256 = "219bc7280bbb9305938d76067c816954ad2cc0629063412e8b765e9bc6972304",
    strip_prefix = "rules_foreign_cc-ed3db61a55c13da311d875460938c42ee8bbc2a5",
    url = "https://github.com/bazelbuild/rules_foreign_cc/archive/ed3db61a55c13da311d875460938c42ee8bbc2a5.tar.gz",  # 2019-12-01
)

load("@rules_foreign_cc//:workspace_definitions.bzl", "rules_foreign_cc_dependencies")

rules_foreign_cc_dependencies([
    "//bazel:built_cmake_toolchain",
])

http_archive(
    name = "com_github_westes_flex",
    build_file_content = ALL_CONTENT,
    sha256 = "e87aae032bf07c26f85ac0ed3250998c37621d95f8bd748b31f15b33c45ee995",
    strip_prefix = "flex-2.6.4",
    url = "https://github.com/westes/flex/releases/download/v2.6.4/flex-2.6.4.tar.gz",  # 2017-05-07
)
