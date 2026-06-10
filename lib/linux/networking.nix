{
  pkgs,
  shared,
  restrictNetwork,
  allowedDomains,
  _proxyRedirects ? { },
}:
let
  mkAllowlistFile = shared.mkAllowlistFile;
  hasAllowedDomains = shared.hasAllowedDomains;
  mkProxyStartupBashStr = shared.mkProxyStartupBashStr;
  pastaGatewayIp = "10.0.2.2";
  pastaNamespaceIp = "10.0.2.1";
  # Route-restriction script runs inside pasta's namespace (before bwrap).
  # Removes the default route so the namespace cannot reach the wider
  # internet directly. The proxy is bound on 127.0.0.1 on the host;
  # pasta forwards 10.0.2.2:<port> → 127.0.0.1:<port>, so the sandbox
  # only needs to reach the pasta gateway — the host LAN IP is never needed.
  # Installs an nftables OUTPUT chain with default-drop policy. Only
  # in-namespace loopback and TCP to the proxy port on the pasta gateway
  # are accepted — all other protocols (UDP, ICMP, …) and non-proxy TCP
  # ports are blocked.
  routeRestrictScript =
    pkgs.writeScript "sandbox-route-restrict"
      # bash
      ''
        #!${pkgs.bashInteractive}/bin/bash
        set -euo pipefail
        IP="${pkgs.iproute2}/bin/ip"
        NFT="${pkgs.nftables}/bin/nft"
        $IP route del default || { echo "${shared.errorPrefix} could not remove default route" >&2; exit 1; }
        $NFT add table ip sandbox_filter
        $NFT add chain ip sandbox_filter output '{ type filter hook output priority 0 ; policy drop ; }'
        $NFT add rule ip sandbox_filter output oif lo accept
        $NFT add rule ip sandbox_filter output ip daddr ${pastaGatewayIp} tcp dport "$SANDBOX_PROXY_PORT" accept
        exec "$@"
      '';
in
if restrictNetwork then
  let
    allowlistFileStr = mkAllowlistFile allowedDomains;
  in
  {
    warnIgnoredDomainsBashStr = "";
    proxyEnvBubblewrapStr = ''--setenv HTTP_PROXY "http://${pastaGatewayIp}:$_PROXY_PORT" --setenv HTTPS_PROXY "http://${pastaGatewayIp}:$_PROXY_PORT" --setenv http_proxy "http://${pastaGatewayIp}:$_PROXY_PORT" --setenv https_proxy "http://${pastaGatewayIp}:$_PROXY_PORT"'';

    caCertBubblewrapStr = ''--ro-bind "$_COMBINED_CA_BUNDLE" /tmp/sandbox-ca-bundle.pem --ro-bind "$_CA_CERT_FILE" /tmp/sandbox-ca-cert.pem --setenv SSL_CERT_FILE /tmp/sandbox-ca-bundle.pem --setenv NIX_SSL_CERT_FILE /tmp/sandbox-ca-bundle.pem --setenv NODE_EXTRA_CA_CERTS /tmp/sandbox-ca-cert.pem --setenv REQUESTS_CA_BUNDLE /tmp/sandbox-ca-bundle.pem'';
    proxyStartupBashStr = mkProxyStartupBashStr allowlistFileStr "127.0.0.1" _proxyRedirects;

    bashCleanupCommandsStr =
      # bash
      ''kill $_PROXY_PID 2>/dev/null; rm -f "$_CA_CERT_FILE" "$_COMBINED_CA_BUNDLE"'';

    sandboxExecBashStr = # bash
      ''SANDBOX_PROXY_PORT="$_PROXY_PORT" ${pkgs.passt}/bin/pasta -4 --config-net -a ${pastaNamespaceIp} -g ${pastaGatewayIp} -n 255.255.255.0 -t none -u none -T none -U none -- ${routeRestrictScript} '';
    etcResolvBind = "--ro-bind /dev/null /etc/resolv.conf"; # Block DNS resolution when restrictNetwork is true.
    sslCertEnvBubblewrapStr = ""; # CA cert env vars are set in caCertBubblewrapStr
  }
else
  {
    warnIgnoredDomainsBashStr =
      if (hasAllowedDomains allowedDomains) then
        # bash
        ''
          echo "${shared.warnPrefix} allowedDomains is set but restrictNetwork is false — domains will be ignored" >&2
        ''
      else
        "";
    proxyEnvBubblewrapStr = "";
    caCertBubblewrapStr = "";
    proxyStartupBashStr = "";
    bashCleanupCommandsStr = "";
    sandboxExecBashStr = "exec ";

    etcResolvBind = "--ro-bind /etc/resolv.conf /etc/resolv.conf"; # Normal DNS resolution when restrictNetwork is false.

    sslCertEnvBubblewrapStr = ''--setenv SSL_CERT_FILE "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt" --setenv NIX_SSL_CERT_FILE "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"'';
  }
