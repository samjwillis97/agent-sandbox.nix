# Test fixture: network restricted with a tunnel (TLS passthrough) domain.
# "httpbin.org" is tunnelled (raw TCP, no MITM) so the client sees the real
# upstream cert. The MITM contrast in test-network.sh reuses the
# method-filtered fixture, where httpbin.org is intercepted instead.
let
  pkgs = import <nixpkgs> { };
  sandbox = import ../../default.nix { pkgs = pkgs; };
in sandbox.mkSandbox {
  pkg = pkgs.bash;
  binName = "bash";
  outName = "sandboxed-bash-tunnel";
  allowedPackages = [ pkgs.coreutils pkgs.bash pkgs.curl ];
  allowedDomains = {
    "httpbin.org" = "tunnel";
  };
}
