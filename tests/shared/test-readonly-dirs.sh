#!/usr/bin/env bash
# readOnlyDirs tests (shared across platforms)
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/../lib.sh"

SANDBOXED=$(nix-build --no-out-link "$SCRIPT_DIR/../fixtures/readonly-dirs-sandbox.nix")
SHELL="$SANDBOXED/bin/sandboxed-bash-readonly"

run() { "$SHELL" --norc --noprofile -c "$@" >/dev/null 2>&1; }
run_output() { "$SHELL" --norc --noprofile -c "$@" 2>/dev/null; }

TESTDIR_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)/.tmp-test"
mkdir -p "$TESTDIR_ROOT"
TESTDIR=$(mktemp -d "$TESTDIR_ROOT/readonly.XXXXXX")
trap 'rm -rf "$TESTDIR"' EXIT
cd "$TESTDIR"

# Seed the readOnlyDir with a test file before entering the sandbox
mkdir -p "$HOME/.test-readonly-dir"
echo "readonly-content" > "$HOME/.test-readonly-dir/test-file"

# Seed the stateDir with a test file to confirm rw still works
mkdir -p "$HOME/.test-state-dir"
echo "writable-content" > "$HOME/.test-state-dir/test-file"

echo "=== readOnlyDirs tests (shared) ==="
echo

# --- readOnlyDirs: can read ---
expect_ok "can read files in readOnlyDir" "cat \$HOME/.test-readonly-dir/test-file"

if [ "$(run_output 'cat $HOME/.test-readonly-dir/test-file')" = "readonly-content" ]; then
	echo "PASS: readOnlyDir file has correct content"
	PASS=$((PASS + 1))
else
	echo "FAIL: readOnlyDir file has wrong content"
	FAIL=$((FAIL + 1))
fi

# --- readOnlyDirs: cannot write ---
expect_fail "cannot write to readOnlyDir" "touch \$HOME/.test-readonly-dir/new-file"
expect_fail "cannot modify files in readOnlyDir" "echo modified > \$HOME/.test-readonly-dir/test-file"
expect_fail "cannot delete files in readOnlyDir" "rm \$HOME/.test-readonly-dir/test-file"

# --- stateDirs: still writable (control test) ---
expect_ok "can write to stateDir" "touch \$HOME/.test-state-dir/new-file"
expect_ok "can read from stateDir" "cat \$HOME/.test-state-dir/test-file"

print_results
exit_status
