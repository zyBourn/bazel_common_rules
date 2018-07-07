# MIT License
#
# Copyright (c) 2018 magoko
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

"""Check Bazel version
We recommend forcing all users to update to at least the same version of Bazel
as the continuous integration, so they don't trip over incompatibilities with
rules used in the project.
"""

# From https://github.com/tensorflow/tensorflow/blob/5541ef4fbba56cf8930198373162dd3119e6ee70/tensorflow/workspace.bzl#L44

# Parse the bazel version string from `native.bazel_version`.
# The format is "<major>.<minor>.<patch>-<date> <commit>"
# Returns a 3-tuple of numbers: (<major>, <minor>, <patch>)
def _parse_bazel_version(bazel_version):
  # Remove commit from version.
  version = bazel_version.split(" ", 1)[0]

  # Split into (release, date) parts and only return the release
  # as a tuple of integers.
  parts = version.split("-", 1)
  # Handle format x.x.xrcx
  parts = parts[0].split("rc", 1)

  # Turn "release" into a tuple of numbers
  version_tuple = ()
  for number in parts[0].split("."):
    version_tuple += (int(number),)
  return version_tuple

# Check that a specific bazel version is being used.
# Args: bazel_version in the form "<major>.<minor>.<patch>"
def check_bazel_version(bazel_version):
  """
  Verify the users Bazel version is at least the given one.
  This should be called from the `WORKSPACE` file so that the build fails as
  early as possible. For example:
  ```
  # in WORKSPACE:
  load("@org_magoko_bazel_common_rules//:defs.bzl", "check_bazel_version")
  check_bazel_version("0.11.0")
  ```
  Args:
    bazel_version: a string indicating the minimum version
  """
  if "bazel_version" not in dir(native):
    fail("\nCurrent Bazel version is lower than 0.2.1, expected at least %s\n" %
         bazel_version)
  elif not native.bazel_version:
    print("\nCurrent Bazel is not a release version, cannot check for " +
          "compatibility.")
    print("Make sure that you are running at least Bazel %s.\n" % bazel_version)
  else:
    current_bazel_version = _parse_bazel_version(native.bazel_version)
    minimum_bazel_version = _parse_bazel_version(bazel_version)
    if minimum_bazel_version > current_bazel_version:
      fail("\nCurrent Bazel version is {}, expected at least {}\n".format(
          native.bazel_version, bazel_version))