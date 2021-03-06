load("@bazel_skylib//:bzl_library.bzl", "bzl_library")
load("@io_bazel_rules_docker//contrib/automatic_container_release:packages_metadata.bzl", "packages_metadata")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("@io_bazel_rules_docker//docker/package_managers:apt_key.bzl", "add_apt_key")
load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load(
    "@io_bazel_rules_docker//docker/toolchain_container:toolchain_container.bzl",
    "language_tool_layer",
    "toolchain_container",
)

package(default_visibility = ["//visibility:public"])

exports_files(glob(["*.yaml"]))

bzl_library(
    name = "lib",
    srcs = glob(["*.bzl"]),
)

# Downloading "docker-ce" requires "apt-transport-https" to be installed
# in the container. So create a prerequisite container first.
toolchain_container(
    name = "docker-prereq",
    base = "@ubuntu1804//image",
    packages = [
        "apt-transport-https",
        "ca-certificates",
        "curl",
    ],
)

add_apt_key(
    name = "docker-key-image",
    image = ":docker-prereq.tar",
    keys = [
        "@docker_gpg//file",
    ],
)

download_pkgs(
    name = "docker_debs",
    additional_repos = [
        "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable",
    ],
    image_tar = ":docker-key-image.tar",
    packages = [
        "docker-ce",
    ],
)

# Transform the packages metadata csv produced by download_pkgs into a YAML
# file.
packages_metadata(
    name = "metadata",
    metadata_csv = ":docker_debs_metadata.csv",
)

language_tool_layer(
    name = "docker-ltl",
    base = "@ubuntu1804//image",
    installables_tar = ":docker_debs.tar",
)

container_test(
    name = "test",
    configs = [
        ":tests.yaml",
    ],
    image = ":docker-ltl",
    verbose = True,
)
