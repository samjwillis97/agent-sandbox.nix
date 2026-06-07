#!/usr/bin/env bash
# Test: the data-volume mountpoint at /System/Volumes/Data is not reachable
# from inside the sandbox. Regression for PENTEST-FINDINGS-2026-06.md §2 —
# the broad (subpath "/System") allow used to expose the entire data volume
# via its canonical /System/Volumes/Data/... address, bypassing the
# /Library/Preferences fix in PR #42 (and every other narrower deny on a
# synthetic-root path).
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/../lib.sh"

SANDBOXED=$(nix-build --no-out-link "$SCRIPT_DIR/../fixtures/basic-sandbox.nix")
SHELL="$SANDBOXED/bin/sandboxed-bash"

run() { "$SHELL" --norc --noprofile -c "$@" >/dev/null 2>&1; }

TESTDIR_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)/.tmp-test"
mkdir -p "$TESTDIR_ROOT"
TESTDIR=$(mktemp -d "$TESTDIR_ROOT/system-volumes-data-denied.XXXXXX")
trap 'rm -rf "$TESTDIR"' EXIT
cd "$TESTDIR"

echo "=== /System/Volumes/* denied (Darwin) ==="
echo

# The synthetic-root paths these firmlink to are already covered by
# test-library-preferences-denied.sh and test-user-folders-denied.sh.
# This test covers the canonical Data-volume address that bypasses them.
expect_fail "cannot enumerate /System/Volumes/Data" \
  "ls /System/Volumes/Data"
expect_fail "cannot enumerate /System/Volumes/Data/Library/Preferences" \
  "ls /System/Volumes/Data/Library/Preferences"
expect_fail "cannot read SystemConfiguration/preferences.plist via Data" \
  "cat /System/Volumes/Data/Library/Preferences/SystemConfiguration/preferences.plist"
expect_fail "cannot read NetworkInterfaces.plist via Data" \
  "cat /System/Volumes/Data/Library/Preferences/SystemConfiguration/NetworkInterfaces.plist"
expect_fail "cannot read loginwindow.plist via Data" \
  "cat /System/Volumes/Data/Library/Preferences/com.apple.loginwindow.plist"
expect_fail "cannot read bluetooth.plist via Data" \
  "cat /System/Volumes/Data/Library/Preferences/com.apple.bluetooth.plist"

# Other mountpoints under /System/Volumes are also denied — Preboot leaks
# a stable per-boot UUID via its directory name, Update stages OS updates.
expect_fail "cannot enumerate /System/Volumes/Preboot" \
  "ls /System/Volumes/Preboot"
expect_fail "cannot enumerate /System/Volumes/Update" \
  "ls /System/Volumes/Update"

# Sanity: the legitimate /System reads still work — these are how Apple
# frameworks load and we'd break almost everything if they regressed.
expect_ok "can read /System/Library" \
  "test -d /System/Library && ls /System/Library >/dev/null"
expect_ok "can read /System/Library/Frameworks/Foundation.framework" \
  "test -d /System/Library/Frameworks/Foundation.framework"
expect_ok "can read /System/Library/CoreServices/SystemVersion.plist" \
  "cat /System/Library/CoreServices/SystemVersion.plist >/dev/null"

print_results
exit_status
