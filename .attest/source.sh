#!/usr/bin/env bash
# Source assembly: release tags (for the version string) + the submodules the build needs.
# Runs inside the clone.
set -euo pipefail
# The fork has no release-* tags of its own; fetch them from upstream so
# `git describe` produces the same version string upstream would.
git fetch --no-tags https://github.com/darktable-org/darktable 'refs/tags/release-*:refs/tags/release-*'
git submodule init
git config submodule.src/tests/integration.update none
git submodule update
