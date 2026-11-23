#!/usr/bin/env bash
# Applies the patches to a checkout of the Sonic Mania decompilation.
#
#   ./apply.sh /path/to/Sonic-Mania-Decompilation          # 1 + 2: iOS/widescreen + touch controls
#   ./apply.sh /path/to/Sonic-Mania-Decompilation --no-touch # 1 only: iOS/widescreen (+ Heavy Shinobi fix)
#
# Patch 2 (touch controls) is meant to be applied on top of patch 1.
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
DECOMP="${1:?path to Sonic-Mania-Decompilation checkout}"
WITH_TOUCH=1
[ "${2:-}" = "--no-touch" ] && WITH_TOUCH=0

apply_set() {
    git -C "$DECOMP" apply --whitespace=nowarn "$HERE/patches/$1/sonic-mania.patch"
    git -C "$DECOMP/dependencies/RSDKv5" apply --whitespace=nowarn "$HERE/patches/$1/rsdkv5.patch"
    echo "applied: $1"
}

apply_set 1-ios-widescreen
[ "$WITH_TOUCH" = 1 ] && apply_set 2-touch-controls
echo "Done. See README.md -> Building."
