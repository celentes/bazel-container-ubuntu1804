workspace(name = "bazel_container_ubuntu1804")

load(
    "@bazel_tools//tools/build_defs/repo:http.bzl",
    "http_archive",
)

http_archive(
    name = "io_bazel_rules_docker",
    sha256 = "feb53c560be2f97b7d02b23a1738a3154ba89fe630f09a7a838dcad38731b0b8",
    strip_prefix = "rules_docker-faaa10a72fa9abde070e2a20d6046e9f9b849e9a",
    urls = ["https://github.com/bazelbuild/rules_docker/archive/faaa10a72fa9abde070e2a20d6046e9f9b849e9a.tar.gz"],
)

http_archive(
    name = "layer_definitions",
    sha256 = "9fc2e0ec9a2ec5c4a61fa457f877e8cf9ccd93e6b969b5f8e1005dc1789bc1cc",
    strip_prefix = "layer-definitions-2f6c8895dfe0a580253b6d8da1c1744e515806db",
    urls = ["https://github.com/GoogleCloudPlatform/layer-definitions/archive/2f6c8895dfe0a580253b6d8da1c1744e515806db.tar.gz"],
)

load("@io_bazel_rules_docker//repositories:repositories.bzl", container_repositories = "repositories")
container_repositories()

load("@io_bazel_rules_docker//repositories:deps.bzl", container_deps = "deps")
container_deps()

load("@io_bazel_rules_docker//repositories:pip_repositories.bzl", "pip_deps")
pip_deps()

load("@layer_definitions//layers/ubuntu1804/base:deps.bzl", ubuntu1604_base_deps = "deps")
ubuntu1604_base_deps()

load("//layers/bazel:deps.bzl", bazel_deps = "deps")
bazel_deps()

load("@layer_definitions//layers/ubuntu1804/clang:deps.bzl", clang_deps = "deps")
clang_deps()

load("@layer_definitions//layers/ubuntu1804/java:deps.bzl", java8_deps = "deps")
java8_deps()

load("@layer_definitions//layers/ubuntu1804/python:deps.bzl", python_deps = "deps")
python_deps()
