# Alternative to official bazel container
Currently, `l.gcr.io/google/bazel` has not been updated since 3.5.0 and contains some other issues.
This repository aims to fix that.

### Usage
```bash
docker pull celentes/ubuntu1804-bazel
```

### Extra
* Fixes bazel container not supporting unicode filenames as sources
* Adds ibazel to the image
