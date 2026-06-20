#!/usr/bin/env bash
# Fill version + sha256 in Casks/clipfix.rb from a published ClipFix GitHub release.
#
#   scripts/update-cask.sh 0.1.0
#
# First release: replaces the REPLACE_WITH_* placeholders.
# Later bumps: prefer `brew bump-cask-pr --version <new> clipfix` (handles the PR),
# or re-run this against a fresh checkout.
set -euo pipefail

VERSION="${1:?usage: scripts/update-cask.sh <version, e.g. 0.1.0>}"
REPO="NicolasArnouts/ClipFix"
BASE="https://github.com/${REPO}/releases/download/v${VERSION}"
CASK="$(cd "$(dirname "$0")/.." && pwd)/Casks/clipfix.rb"

TMP="$(mktemp -d)"; trap 'rm -rf "$TMP"' EXIT
arm_dmg="ClipFix_${VERSION}_aarch64.dmg"
x64_dmg="ClipFix_${VERSION}_x64.dmg"

echo "Downloading release assets for v${VERSION} ..."
curl -fSL "${BASE}/${arm_dmg}" -o "${TMP}/${arm_dmg}"
curl -fSL "${BASE}/${x64_dmg}" -o "${TMP}/${x64_dmg}"

arm_sha="$(shasum -a 256 "${TMP}/${arm_dmg}" | awk '{print $1}')"
x64_sha="$(shasum -a 256 "${TMP}/${x64_dmg}" | awk '{print $1}')"
echo "  aarch64 sha256: ${arm_sha}"
echo "  x64     sha256: ${x64_sha}"

sed -i '' -E "s/^  version \".*\"/  version \"${VERSION}\"/" "${CASK}"
# Replace the sha256 inside the on_arm / on_intel blocks. Re-runnable across
# bumps: matches whatever 64-hex value (or the REPLACE_WITH_* placeholder) is
# currently there, not a fixed string.
perl -0pi -e "s/(on_arm do\s*\n\s*sha256 \")([0-9a-f]{64}|REPLACE_WITH_AARCH64_DMG_SHA256)(\")/\${1}${arm_sha}\${3}/s" "${CASK}"
perl -0pi -e "s/(on_intel do\s*\n\s*sha256 \")([0-9a-f]{64}|REPLACE_WITH_X64_DMG_SHA256)(\")/\${1}${x64_sha}\${3}/s" "${CASK}"

echo
echo "Updated ${CASK}"
echo "Next:  brew audit --cask --strict Casks/clipfix.rb  &&  git commit -am \"clipfix ${VERSION}\" && git push"
