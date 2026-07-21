{
  pkgs,
  shared,
  allowedDomains,
  allowedLocalPorts,
  allowNetworkBind,
  allowUnixSocketConnect,
  _proxyRedirects ? { },
}:
let
  mkAllowlistFile = shared.mkAllowlistFile;
  mkProxyStartupBashStr = shared.mkProxyStartupBashStr;
  darwinAllowedLocalPortsRulesStr = builtins.concatStringsSep "\n" (
    map (port: "        (allow network-outbound (remote ip \"localhost:${port}\"))") (
      if allowedLocalPorts == null then [ "*" ] else map toString allowedLocalPorts
    )
  );
in
if allowedDomains != null then
  let
    allowlistFileStr = mkAllowlistFile allowedDomains;
  in
  {
    proxyEnvInlineBashStr =
      # bash
      ''HTTP_PROXY="http://127.0.0.1:$_PROXY_PORT" HTTPS_PROXY="http://127.0.0.1:$_PROXY_PORT" http_proxy="http://127.0.0.1:$_PROXY_PORT" https_proxy="http://127.0.0.1:$_PROXY_PORT"'';
    caCertEnvInlineBashStr =
      # bash
      ''SSL_CERT_FILE="$_COMBINED_CA_BUNDLE" NIX_SSL_CERT_FILE="$_COMBINED_CA_BUNDLE" NODE_EXTRA_CA_CERTS="$_CA_CERT_FILE" REQUESTS_CA_BUNDLE="$_COMBINED_CA_BUNDLE"'';
    networkSeatbeltRulesStr =
      # scheme
      ''
        ;; Network — restricted to localhost only (proxy-based domain filtering).
        ;; The outbound localhost rule is appended at runtime by
        ;; networkRuntimePatchBashStr once the proxy port is known, so it can
        ;; be pinned to that specific port. This prevents the sandbox from
        ;; reaching other loopback services (local databases, dev servers,
        ;; etc.) directly, bypassing the proxy's domain/method filtering.
        ;;
        ;; UNIX-socket egress is denied by default. Set
        ;; allowUnixSocketConnect to grant outbound AF_UNIX connections.
        ${
          if allowNetworkBind then
            ''
              (allow network-bind)
              (allow network-inbound)''
          else
            "(allow network-bind (local ip \"localhost:*\"))"
        }
        (allow system-socket)
        ${darwinAllowedLocalPortsRulesStr}
        ${
          if allowUnixSocketConnect then
            "(allow network-outbound (remote unix-socket))"
          else
            ""
        }
      '';
    proxyStartupBashStr = mkProxyStartupBashStr allowlistFileStr "127.0.0.1" _proxyRedirects;
    networkRuntimePatchBashStr =
      # bash
      ''
        printf '    (allow network-outbound (remote ip "localhost:%s"))\n' "$_PROXY_PORT" >> "$SANDBOX_PROFILE"
      '';
    bashTrapCleanupStr =
      # bash
      ''
        trap 'kill $_PROXY_PID 2>/dev/null; rm -f "$_CA_CERT_FILE" "$_COMBINED_CA_BUNDLE"; rm -f "$_SANDBOX_PASSWD"; rm -rf "$SANDBOX_HOME" "$SANDBOX_PROFILE"' EXIT
      '';
    sandboxExecBashStr = "";
  }
else
  {
    proxyEnvInlineBashStr = "";
    caCertEnvInlineBashStr =
      # bash
      ''SSL_CERT_FILE="${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt" NIX_SSL_CERT_FILE="${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"'';
    networkSeatbeltRulesStr =
      # scheme
      ''
        ;; Network. (allow network*) is permissive across bind/inbound/
        ;; outbound and across IP families and protocols (including AF_UNIX
        ;; outbound). The scoped denies below narrow it to match the
        ;; README's "no local services" promise:
        ;;
        ;;   - The IP-loopback deny blocks connect() to 127.0.0.0/8 and
        ;;     ::1 (one rule covers both — verified). Host loopback
        ;;     services (Postgres, dev servers, the SSH agent over TCP,
        ;;     local API mocks, etc.) are unreachable in open mode.
        ;;
        ;;   - The unix-socket deny blocks AF_UNIX connect() by default.
        ;;     Set allowUnixSocketConnect to append a matching allow rule.
        ;;
        ;; seatbelt is last-match-wins, so the denies override the earlier
        ;; (allow network*). The filtered branch reaches the same
        ;; loopback/UNIX-deny end state by a different mechanism: it never
        ;; grants (allow network*) in the first place, only a proxy-port-
        ;; pinned (allow network-outbound (remote ip "localhost:<port>")),
        ;; plus the explicit Unix-socket opt-in above.
        ;;
        ;; (allow system-socket) — kept; it gates socket(PF_SYSTEM, ...)
        ;; (kernel-control sockets, utun, etc.), not AF_UNIX, and matches
        ;; what the filtered branch grants.
        ;;
        ;; mDNSResponder exception: macOS getaddrinfo() resolves names via
        ;; /private/var/run/mDNSResponder (AF_UNIX). The blanket unix-socket
        ;; deny above would kill all in-sandbox DNS — curl, git over HTTPS,
        ;; etc. — so we re-allow that one path when the explicit Unix-socket
        ;; opt-in is not enabled. The deny still wins for every other
        ;; AF_UNIX target (ssh-agent, terminal IPC, app sockets under
        ;; /private/tmp, …).
        (allow network*)
        (allow system-socket)
        (deny network-outbound (remote ip "localhost:*"))
        (deny network-outbound (remote unix-socket))
        ${
          if allowUnixSocketConnect then
            "(allow network-outbound (remote unix-socket))"
          else
            ''
              (allow network-outbound
                (remote unix-socket (path-literal "/private/var/run/mDNSResponder")))''
        }
        ${darwinAllowedLocalPortsRulesStr}
      '';
    proxyStartupBashStr = "";
    networkRuntimePatchBashStr = "";
    bashTrapCleanupStr =
      # bash
      ''
        trap 'rm -f "$_SANDBOX_PASSWD"; rm -rf "$SANDBOX_HOME" "$SANDBOX_PROFILE"' EXIT
      '';
    sandboxExecBashStr = "exec ";
  }
