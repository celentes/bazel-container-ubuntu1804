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
    name = "bazel_debs",
    image_tar = "@ubuntu1804//image",
    packages = [
        "bash-completion",
        "binutils",
        "file",
        "git",
        "make",
        "openssh-client",
        "patch",
        "unzip",
        "wget",
        "xz-utils",
        "zip",
    ],
)

# Transform the packages metadata csv produced by download_pkgs into a YAML
# file.
packages_metadata(
    name = "metadata",
    metadata_csv = ":bazel_debs_metadata.csv",
)

# Create intermediate images with the Bazel installer.
# Note that this image is not the Bazel container but an intermediate image
# that we use to create the Bazel layer.
toolchain_container(
    name = "bazel_installer_image",
    base = "@ubuntu1804//image",
    files = [
        ":bazel.bazelrc",
        "@bazel_installer//file",
    ],
    packages = [
        "unzip",
    ],
)

# Extract the Bazel binary.
container_run_and_extract(
    name = "bazel_tar",
    commands = [
        "mv /bazel.bazelrc /etc/bazel.bazelrc",
        "chmod +x /bazel-installer.sh",
        "/bazel-installer.sh",
        "tar cvf /bazel.tar --mtime='1970-01-01' /usr/local/lib/bazel/* /etc/bazel.bazelrc",
    ],
    extract_file = "/bazel.tar",
    image = ":bazel_installer_image.tar",
)

# Bazel language_tool_layer target.
# Note that we do not add other tools/compilers required by Bazel
# (e.g., CC compiler, JDK) here as we include them in the final container.
language_tool_layer(
    name = "bazel-ltl",
    base = "@ubuntu1804//image",
    installables_tar = ":bazel_debs.tar",
    symlinks = {
        "/usr/local/bin/bazel": "/usr/local/lib/bazel/bin/bazel",
    },
    tars = [":bazel_tar/bazel.tar"],
)

container_test(
    name = "test",
    configs = [
        ":tests.yaml",
    ],
    image = ":bazel-ltl",
    verbose = True,
)
