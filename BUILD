load(
    "@io_bazel_rules_docker//container:container.bzl",
    "container_image", "container_push"
)
load(
    "@io_bazel_rules_docker//contrib/automatic_container_release:configs_test.bzl",
    "configs_test",
)
load("@io_bazel_rules_docker//contrib:repro_test.bzl", "container_repro_test")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load(
    "@io_bazel_rules_docker//docker/toolchain_container:toolchain_container.bzl",
    "toolchain_container",
)

package(default_visibility = ["//visibility:public"])

# Generate an intermediate image.
toolchain_container(
    name = "image_intermediate",
    base = "@ubuntu1804//image",
    # Remove non-deterministic files.
    installation_cleanup_commands = "rm -f /etc/init.d/.depend.boot /etc/init.d/.depend.start /etc/init.d/.depend.stop /var/cache/apt/srcpkgcache.bin",
    language_layers = [
        "@layer_definitions//layers/ubuntu1804/clang:clang-ltl",
        "@layer_definitions//layers/ubuntu1804/java:java-ltl",
        "@layer_definitions//layers/ubuntu1804/java:java11-ltl",
        "@layer_definitions//layers/ubuntu1804/python:python-ltl",
        "//layers/bazel:bazel-ltl",
        "//layers/docker:docker-ltl",
        "//layers/ibazel:ibazel-ltl",
        #"//layers/pip:pip-ltl",
    ],
)

toolchain_container(
    name = "image-intermediate-glvnd",
    base = "@ubuntu1804//image",
    # Remove non-deterministic files.
    installation_cleanup_commands = "rm -f /etc/init.d/.depend.boot /etc/init.d/.depend.start /etc/init.d/.depend.stop /var/cache/apt/srcpkgcache.bin",
    language_layers = [
        "@layer_definitions//layers/ubuntu1804/clang:clang-ltl",
        "@layer_definitions//layers/ubuntu1804/java:java-ltl",
        "@layer_definitions//layers/ubuntu1804/java:java11-ltl",
        "@layer_definitions//layers/ubuntu1804/python:python-ltl",
        "//layers/bazel:bazel-ltl",
        "//layers/docker:docker-ltl",
        "//layers/ibazel:ibazel-ltl",
        #"//layers/pip:pip-ltl",
        "//layers/glvnd:glvnd-ltl",
    ],
)

container_image(
    name = "image",
    base = ":image_intermediate",
    env = {
        "LANG": "C.UTF-8",
        "LANGUAGE": "C.UTF-8",
        "LC_ALL": "C.UTF-8",
    },
    cmd = None,
    entrypoint = ["/usr/local/bin/bazel"],
)

container_image(
    name = "image-glvnd",
    base = ":image-intermediate-glvnd",
    env = {
        "LANG": "C.UTF-8",
        "LANGUAGE": "C.UTF-8",
        "LC_ALL": "C.UTF-8",
        "NVIDIA_VISIBLE_DEVICES": "all",
        "NVIDIA_DRIVER_CAPABILITIES": "graphics,utility,compute",
    },
    cmd = None,
    entrypoint = ["/usr/local/bin/bazel"],
)

container_test(
    name = "image-test",
    configs = [
        ":tests.yaml",
        "@layer_definitions//layers/ubuntu1804/base:tests.yaml",
        "@layer_definitions//layers/ubuntu1804/clang:tests.yaml",
        "@layer_definitions//layers/ubuntu1804/java:tests.yaml",
        "@layer_definitions//layers/ubuntu1804/python:tests.yaml",
        "//layers/bazel:tests.yaml",
        "//layers/docker:tests.yaml",
        "//layers/ibazel:tests.yaml",
    ],
    image = ":image",
    verbose = True,
)

container_repro_test(
    name = "image-repro-test",
    image = ":image",
    workspace_file = "//:WORKSPACE",
)

container_repro_test(
    name = "image-glvnd-repro-test",
    image = ":image-glvnd",
    workspace_file = "//:WORKSPACE",
)

container_push(
    name = "push_version",
    format = "Docker",
    image = ":image",
    registry = "docker.io",
    repository = "celentes/ubuntu1804-bazel",
    tag = "4.0.0",
)

container_push(
    name = "push_glvnd",
    format = "Docker",
    image = ":image-glvnd",
    registry = "docker.io",
    repository = "celentes/ubuntu1804-bazel",
    tag = "4.0.0-glvnd",
)

container_push(
    name = "push_latest",
    format = "Docker",
    image = ":image",
    registry = "docker.io",
    repository = "celentes/ubuntu1804-bazel",
)
