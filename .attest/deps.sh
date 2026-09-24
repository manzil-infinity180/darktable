#!/usr/bin/env bash
# darktable macOS build dependencies, exactly as upstream nightly.yml installs them.
# Kept as a script so cilock-action can wrap it as one command.
set -euo pipefail
brew untap --force aws/tap || true
brew update > /dev/null || true
cd "$(dirname "$0")/../.ci"
export HOMEBREW_NO_INSTALL_UPGRADE=1
brew bundle --verbose || true
export HOMEBREW_NO_INSTALL_FROM_API=1
brew developer on
gm_formula=$(brew edit --quiet --print-path graphicsmagick)
sed 's/--with-modules/--disable-installed/1' "$gm_formula" > gm_formula.tmp
mv gm_formula.tmp "$gm_formula"
brew reinstall --build-from-source --force --quiet graphicsmagick
