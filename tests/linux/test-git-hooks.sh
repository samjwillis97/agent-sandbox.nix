#!/usr/bin/env bash
# Regression test: .git/hooks and .git/config must be read-only inside the
# sandbox to prevent git hook injection (an agent writing an executable hook
# that runs on the host when the user next runs git pull/merge/commit).
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/../lib.sh"

SANDBOXED=$(nix-build --no-out-link "$SCRIPT_DIR/../fixtures/expose-repo-root.nix")
SHELL="$SANDBOXED/bin/sandboxed-bash"

REPO_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)/.tmp-test"
mkdir -p "$REPO_DIR"
REPO=$(mktemp -d "$REPO_DIR/git-hooks.XXXXXX")
trap 'rm -rf "$REPO"' EXIT
git -C "$REPO" init -q
git -C "$REPO" config user.email "test@test.com"
git -C "$REPO" config user.name "Test"
echo "init" > "$REPO/file.txt"
git -C "$REPO" add -A
git -C "$REPO" commit -q -m "initial"

cd "$REPO"

run() { "$SHELL" --norc --noprofile -c "$@" >/dev/null 2>&1; }

echo "=== Git hook injection protection tests (Linux) ==="
echo

expect_fail "cannot write to .git/hooks (hook injection blocked)" \
    "touch .git/hooks/post-merge"

expect_fail "cannot write to .git/config (core.hooksPath bypass blocked)" \
    "echo '' >> .git/config"

expect_ok ".git remains writable for commits" \
    "echo change >> file.txt && git add file.txt && git commit -m test-commit"

print_results
exit_status
