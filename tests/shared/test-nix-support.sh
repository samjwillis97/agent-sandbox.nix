#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/../lib.sh"

NIX_SUPPORT=$(nix-build --no-out-link "$SCRIPT_DIR/../fixtures/nix-support.nix")
NIX_SUPPORT_SHELL="$NIX_SUPPORT/bin/sandboxed-bash-nix-support"

BASIC=$(nix-build --no-out-link "$SCRIPT_DIR/../fixtures/basic-sandbox.nix")
BASIC_SHELL="$BASIC/bin/sandboxed-bash"

TESTDIR_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)/.tmp-test"
mkdir -p "$TESTDIR_ROOT"
TESTDIR=$(mktemp -d "$TESTDIR_ROOT/nix-support-shared.XXXXXX")
trap 'rm -rf "$TESTDIR"' EXIT
cd "$TESTDIR"

echo "=== Nix support tests (shared) ==="
echo

run() { "$NIX_SUPPORT_SHELL" --norc --noprofile -c "$@" >/dev/null 2>&1; }

expect_ok "nix build succeeds with allowNix" \
    'nix build nixpkgs#hello --no-link'

expect_ok "nix run succeeds with allowNix" \
    'nix run nixpkgs#hello'

expect_ok "nix develop succeeds with allowNix" \
    'nix develop nixpkgs#hello -c true'

run() { "$BASIC_SHELL" --norc --noprofile -c "$@" >/dev/null 2>&1; }

expect_fail "nix build unavailable without allowNix" \
    'nix build nixpkgs#hello --no-link'

expect_fail "nix run unavailable without allowNix" \
    'nix run nixpkgs#hello'

expect_fail "nix develop unavailable without allowNix" \
    'nix develop nixpkgs#hello -c true'

print_results
exit_status
