# Test fixture for Darwin UNIX-socket egress tests. The option defaults to
# denied; callers can set it to exercise the explicit outbound-connect grant.
{ allowUnixSocketConnect ? false, allowedDomains ? [ "anthropic.com" ] }:
let
  pkgs = import <nixpkgs> { };
  sandbox = import ../../default.nix { pkgs = pkgs; };
in sandbox.mkSandbox {
  pkg = pkgs.bashInteractive;
  binName = "bash";
  outName = "sandboxed-bash";
  allowedPackages = [ pkgs.coreutils pkgs.socat ];
  inherit allowUnixSocketConnect allowedDomains;
}
