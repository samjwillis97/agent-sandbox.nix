#!/usr/bin/env bash
# Test: allowUnixSocketConnect permits AF_UNIX connect() in both Darwin
# networking modes while the default-deny behavior remains covered by the
# companion egress-denied test.
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TEST_CWD="$(cd "$SCRIPT_DIR/../.." && pwd)"

source "$SCRIPT_DIR/../lib.sh"

FILTERED=$(nix-build --no-out-link \
	--arg allowUnixSocketConnect true \
	"$SCRIPT_DIR/../fixtures/unix-socket-client-sandbox.nix")
OPEN=$(nix-build --no-out-link \
	--arg allowUnixSocketConnect true \
	--arg allowedDomains null \
	"$SCRIPT_DIR/../fixtures/unix-socket-client-sandbox.nix")
FILTERED_SHELL="$FILTERED/bin/sandboxed-bash"
OPEN_SHELL="$OPEN/bin/sandboxed-bash"

HOST_PYTHON3=$(nix-build --no-out-link -E '(import <nixpkgs> {}).python3Minimal')/bin/python3

CURRENT_SHELL=""
run() {
	(cd "$TEST_CWD" && "$CURRENT_SHELL" --norc --noprofile -c "$@") >/dev/null 2>&1
}

TESTDIR_ROOT="$TEST_CWD/.tmp-test"
mkdir -p "$TESTDIR_ROOT"
TESTDIR=$(mktemp -d "$TESTDIR_ROOT/unix-socket-egress-allowed.XXXXXX")
SOCK_DIR=$(mktemp -d "/private/tmp/sandbox-unix-egress-allowed.XXXXXX")
SOCK_PATH="$SOCK_DIR/listener.sock"
LISTENER_PID=""
cleanup() {
	if [ -n "$LISTENER_PID" ]; then
		kill "$LISTENER_PID" 2>/dev/null || true
		wait "$LISTENER_PID" 2>/dev/null || true
	fi
	rm -rf "$SOCK_DIR" "$TESTDIR"
}
trap cleanup EXIT

"$HOST_PYTHON3" -c '
import socket, sys, signal, threading
s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
s.bind(sys.argv[1])
s.listen(128)
sys.stdout.write("READY\n"); sys.stdout.flush()
def loop():
    while True:
        try:
            c, _ = s.accept()
            c.close()
        except Exception:
            break
threading.Thread(target=loop, daemon=True).start()
signal.pause()
' "$SOCK_PATH" >"$TESTDIR/listener.log" 2>&1 &
LISTENER_PID=$!

for _ in $(seq 1 50); do
	if grep -q '^READY$' "$TESTDIR/listener.log" 2>/dev/null; then
		break
	fi
	sleep 0.1
done
if ! grep -q '^READY$' "$TESTDIR/listener.log" 2>/dev/null; then
	echo "ERROR: host listener never came up" >&2
	cat "$TESTDIR/listener.log" >&2 || true
	exit 1
fi

if [ ! -S "$SOCK_PATH" ]; then
	echo "ERROR: host listener never created $SOCK_PATH" >&2
	exit 1
fi

echo "=== UNIX-socket egress allowed (Darwin) ==="
echo "SOCK_PATH=$SOCK_PATH"
echo

CURRENT_SHELL="$FILTERED_SHELL"
expect_ok "socat is available in filtered mode" "command -v socat"
expect_ok "can connect to host UNIX socket in filtered mode" \
	"printf x | socat -t 2 - UNIX-CONNECT:'$SOCK_PATH'"

CURRENT_SHELL="$OPEN_SHELL"
expect_ok "socat is available in open mode" "command -v socat"
expect_ok "can connect to host UNIX socket in open mode" \
	"printf x | socat -t 2 - UNIX-CONNECT:'$SOCK_PATH'"

print_results
exit_status
