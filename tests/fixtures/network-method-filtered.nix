# Test fixture: network restricted with per-domain method filtering.
# httpbin.test and pie.test are redirected to a local go-httpbin started
# by the test harness, so tests don't depend on public services. The port
# is passed in via --argstr httpbinPort.
{ httpbinPort ? "18918" }:
let
  pkgs = import <nixpkgs> { };
  sandbox = import ../../default.nix { pkgs = pkgs; };
in sandbox.mkSandbox {
  pkg = pkgs.bash;
  binName = "bash";
  outName = "sandboxed-bash-methods";
  allowedPackages = [ pkgs.coreutils pkgs.bash pkgs.curl ];
  allowedDomains = {
    "httpbin.test" = [ "GET" "HEAD" ];
    "pie.test" = "*";
    # Used by test-network.sh to contrast tunnelled TLS with ordinary MITM TLS.
    "httpbin.org" = "*";
  };
  _proxyRedirects = {
    "httpbin.test" = "127.0.0.1:${httpbinPort}";
    "pie.test" = "127.0.0.1:${httpbinPort}";
  };
}
