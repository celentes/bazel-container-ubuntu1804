load("@bazel_skylib//:bzl_library.bzl", "bzl_library")
load("@io_bazel_rules_docker//contrib/automatic_container_release:packages_metadata.bzl", "packages_metadata")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load(
    "@io_bazel_rules_docker//docker/toolchain_container:toolchain_container.bzl",
    "language_tool_layer",
)

package(default_visibility = ["//visibility:public"])

download_pkgs(
    name = "pip_debs",
    image_tar = "@ubuntu1804//image",
    packages = [
        "python3-pip",
        "python3-setuptools",
        "build-essential",
    ],
)

# Clean up commands to run at the end of container generation to remove any
# build specific files.
PYTHON_CLEANUP_COMMANDS = (
    "find /usr/lib/python* -name __pycache__ -exec rm -rf {} +"
)

language_tool_layer(
    name = "pip-ltl",
    base = "@ubuntu1804//image",
    installables_tar = ":pip_debs.tar",
    installation_cleanup_commands = PYTHON_CLEANUP_COMMANDS,
)
