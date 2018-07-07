# Common Rules for Google Bazel

[![TravisCI Build Status](https://travis-ci.org/magoko/bazel_common_rules.svg?branch=master)](https://travis-ci.org/magoko/bazel_common_rules)
[![AppVeyor Build status](https://ci.appveyor.com/api/projects/status/shh2ad6obiskfmbm?svg=true)](https://ci.appveyor.com/project/klarkdots/bazel-common-rules)

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
    commit = "03127410628b356dd91332045abbd24989bf5e10", # always use the latest commit
)
```

[skydoc]: https://github.com/bazelbuild/skydoc
[Windows Support]: https://github.com/bazelbuild/skydoc/issues/58
[bazel instructions]: https://docs.bazel.build/versions/master/install.html