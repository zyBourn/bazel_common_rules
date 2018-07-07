# Common Rules for Google Bazel

[![Build Status](https://travis-ci.org/magoko/bazel_common_rules.svg?branch=master)](https://travis-ci.org/magoko/bazel_common_rules)

## API DOCS
Generating documentation using [skydoc]
But, skydoc don't support windows, See this [Windows Support].


## Installation
First, install a current bazel distribution, following the [bazel instructions].

Next, create a `WORKSPACE` file in your project root (or edit the existing one)
containing:

```python
git_repository(
    name = "io_bazel_rules_sass",
    remote = "https://github.com/bazelbuild/rules_sass.git",
    tag = "0.0.3",
)

load("@io_bazel_rules_sass//sass:sass.bzl", "sass_repositories")
sass_repositories()

git_repository(
    name = "io_bazel_skydoc",
    remote = "https://github.com/bazelbuild/skydoc.git",
    tag = "0.1.4",
)
load("@io_bazel_skydoc//skylark:skylark.bzl", "skydoc_repositories")
skydoc_repositories()

git_repository(
    name = "org_magoko_bazel_common_rules",
    remote = "https://github.com/magoko/bazel_common_rules.git",
    commit = "44d173a2a875474b5570417cbe9772c6154acada", # always use the latest commit
)
```

[skydoc]: https://github.com/bazelbuild/skydoc
[Windows Support]: https://github.com/bazelbuild/skydoc/issues/58
[bazel instructions]: https://docs.bazel.build/versions/master/install.html