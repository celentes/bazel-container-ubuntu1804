load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def deps():
    excludes = native.existing_rules().keys()

    if "ibazel_binary" not in excludes:
        http_file(
            name = "ibazel_binary",
            downloaded_file_path = "ibazel_linux_amd64",
            sha256 = "9a2a5541aef1e02355ca7b1fe25bac037e109711416a8fb571708b919a620d18",
            urls = [
                "https://github.com/bazelbuild/bazel-watcher/releases/download/v0.15.0/ibazel_linux_amd64"
            ],
        )
