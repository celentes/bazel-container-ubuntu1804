load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")

def deps():
    excludes = native.existing_rules().keys()

    if "bazel_installer" not in excludes:
        http_file(
            name = "bazel_installer",
            downloaded_file_path = "bazel-installer.sh",
            sha256 = "bd7a3a583a18640f58308c26e654239d412adaa833b6b6a7b57a216ab62fabc2",
            urls = [
                "https://releases.bazel.build/4.0.0/release/bazel-4.0.0-installer-linux-x86_64.sh",
                "https://github.com/bazelbuild/bazel/releases/download/4.0.0/bazel-4.0.0-installer-linux-x86_64.sh",
            ],
        )
