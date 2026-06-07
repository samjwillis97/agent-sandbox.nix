#!/usr/bin/env bash
# Basic sandbox tests (Linux-specific)
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/../lib.sh"

SANDBOXED=$(nix-build --no-out-link "$SCRIPT_DIR/../fixtures/basic-sandbox.nix")
SHELL="$SANDBOXED/bin/sandboxed-bash"

run() { "$SHELL" --norc --noprofile -c "$@" >/dev/null 2>&1; }

TESTDIR_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)/.tmp-test"
mkdir -p "$TESTDIR_ROOT"
TESTDIR=$(mktemp -d "$TESTDIR_ROOT/basic-linux.XXXXXX")
trap 'rm -rf "$TESTDIR"' EXIT
cd "$TESTDIR"

echo "=== Basic sandbox tests (Linux) ==="
echo

# --- Linux-specific tests ---
expect_ok "/etc is writable tmpfs (ephemeral)" "touch /etc/test && rm /etc/test"
expect_fail "cannot read host /etc/shadow" "cat /etc/shadow"

# --- PID 1 (bwrap) environ is empty (no host env leak via /proc/1/environ) ---
pid1_environ_size=$("$SHELL" --norc --noprofile -c 'wc -c < /proc/1/environ' 2>/dev/null || echo "error")
if [ "$pid1_environ_size" = "0" ]; then
	echo "PASS: /proc/1/environ is empty (bwrap launched with env -i)"
	PASS=$((PASS + 1))
else
	echo "FAIL: /proc/1/environ leaks host env (size=$pid1_environ_size)"
	FAIL=$((FAIL + 1))
fi

# --- Hostname is neutralised (no UTS namespace leak) ---
host_hostname=$(uname -n)
sandbox_hostname=$("$SHELL" --norc --noprofile -c 'uname -n' 2>/dev/null || echo "error")
if [ "$sandbox_hostname" = "sandbox" ] && [ "$sandbox_hostname" != "$host_hostname" ]; then
	echo "PASS: hostname inside sandbox is 'sandbox', not host hostname"
	PASS=$((PASS + 1))
else
	echo "FAIL: sandbox hostname is '$sandbox_hostname' (host: '$host_hostname')"
	FAIL=$((FAIL + 1))
fi

# --- /etc/passwd is a synthetic single-entry file (no host username leak) ---
passwd_line_count=$("$SHELL" --norc --noprofile -c 'wc -l < /etc/passwd' 2>/dev/null || echo "error")
if [ "$passwd_line_count" = "1" ]; then
	echo "PASS: /etc/passwd has exactly 1 line"
	PASS=$((PASS + 1))
else
	echo "FAIL: /etc/passwd has $passwd_line_count lines, expected 1"
	FAIL=$((FAIL + 1))
fi

sandbox_passwd_uid=$("$SHELL" --norc --noprofile -c 'cut -d: -f3 /etc/passwd' 2>/dev/null || echo "error")
if [ "$sandbox_passwd_uid" = "$(id -u)" ]; then
	echo "PASS: /etc/passwd UID matches host UID"
	PASS=$((PASS + 1))
else
	echo "FAIL: /etc/passwd UID is '$sandbox_passwd_uid', expected '$(id -u)'"
	FAIL=$((FAIL + 1))
fi


print_results
exit_status
