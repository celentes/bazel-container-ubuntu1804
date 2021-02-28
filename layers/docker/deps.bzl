load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def deps():
    excludes = native.existing_rules().keys()

    if "docker_gpg" not in excludes:
        http_file(
            name = "docker_gpg",
            downloaded_file_path = "docker_gpg",
            sha256 = "1500c1f56fa9e26b9b8f42452a553675796ade0807cdce11975eb98170b3a570",
            urls = ["https://download.docker.com/linux/ubuntu/gpg"],
        )
