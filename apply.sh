#!/usr/bin/env bash
# Applies the iOS port + touch controls to a checkout of the Sonic Mania decompilation.
# Usage: ./apply.sh /path/to/Sonic-Mania-Decompilation
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
DECOMP="${1:?path to Sonic-Mania-Decompilation checkout}"

git -C "$DECOMP" apply --whitespace=nowarn "$HERE/patches/sonic-mania.patch"
git -C "$DECOMP/dependencies/RSDKv5" apply --whitespace=nowarn "$HERE/patches/rsdkv5.patch"
echo "Patches applied. Now see README.md -> Building."
