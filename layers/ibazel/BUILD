load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load(
    "@io_bazel_rules_docker//container:container.bzl",
    "container_image", "container_push"
)
load(
    "@io_bazel_rules_docker//docker/toolchain_container:toolchain_container.bzl",
    "language_tool_layer"
)
load("@io_bazel_rules_docker//docker/util:run.bzl", "container_run_and_extract")

package(default_visibility = ["//visibility:public"])

exports_files(glob(["*.yaml"]))

# Create intermediate image
container_image(
    name = "ibazel_intermediary",
    base = "@ubuntu1804//image",
    files = [
        "@ibazel_binary//file",
    ],
)

# Extract the iBazel binary.
container_run_and_extract(
    name = "ibazel_tar",
    commands = [
        "chmod +x /ibazel_linux_amd64",
        "mv /ibazel_linux_amd64 /usr/local/bin/ibazel",
        "tar cvf /ibazel.tar --mtime='1970-01-01' /usr/local/bin/ibazel",
    ],
    extract_file = "/ibazel.tar",
    image = ":ibazel_intermediary.tar",
)

language_tool_layer(
    name = "ibazel-ltl",
    base = "@ubuntu1804//image",
    tars = [":ibazel_tar/ibazel.tar"],
)

container_test(
    name = "test",
    configs = [
        ":tests.yaml",
    ],
    image = ":ibazel-ltl",
    verbose = True,
)
