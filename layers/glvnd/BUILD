load("@bazel_skylib//:bzl_library.bzl", "bzl_library")
load("@io_bazel_rules_docker//contrib/automatic_container_release:packages_metadata.bzl", "packages_metadata")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load(
    "@io_bazel_rules_docker//docker/toolchain_container:toolchain_container.bzl",
    "language_tool_layer",
    "toolchain_container",
)
load("@io_bazel_rules_docker//docker/util:run.bzl", "container_run_and_extract")

package(default_visibility = ["//visibility:public"])

exports_files(glob(["*.yaml"]))

bzl_library(
    name = "lib",
    srcs = glob(["*.bzl"]),
)

download_pkgs(
    name = "glvnd_debs",
    image_tar = "@ubuntu1804//image",
    packages = [
        "libglvnd0",
        "libgl1",
        "libglx0",
        "libegl1",
        "libglvnd-dev",
        "libgl1-mesa-dev",
        "libegl1-mesa-dev",
        "libxext6",
        "libx11-6",
    ],
)

# Transform the packages metadata csv produced by download_pkgs into a YAML
# file.
packages_metadata(
    name = "metadata",
    metadata_csv = ":glvnd_debs_metadata.csv",
)

language_tool_layer(
    name = "glvnd-ltl",
    base = "@ubuntu1804//image",
    installables_tar = ":glvnd_debs.tar",
)

#container_test(
#    name = "test",
#    configs = [
#        ":tests.yaml",
#    ],
#    image = ":glvnd-ltl",
#    verbose = True,
#)
