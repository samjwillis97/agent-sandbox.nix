# Test fixture: roDir + roFile read-only binds. Tests pre-populate
# $HOME/.test-ro-dir and $HOME/.test-ro-file with known content before
# invoking the sandbox.
let
  pkgs = import <nixpkgs> { };
  sandbox = import ../../default.nix { pkgs = pkgs; };
in sandbox.mkSandbox {
  pkg = pkgs.bashInteractive;
  binName = "bash";
  outName = "sandboxed-bash-ro-binds";
  allowedPackages = [ pkgs.coreutils ];
  roDirs = [ "$HOME/.test-ro-dir" ];
  roFiles = [ "$HOME/.test-ro-file" ];
}
