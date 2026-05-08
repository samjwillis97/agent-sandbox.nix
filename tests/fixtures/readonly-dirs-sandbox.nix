# Test fixture: readOnlyDirs — directories bound read-only into sandbox
let
  pkgs = import <nixpkgs> { };
  sandbox = import ../../default.nix { pkgs = pkgs; };
in sandbox.mkSandbox {
  pkg = pkgs.bashInteractive;
  binName = "bash";
  outName = "sandboxed-bash-readonly";
  allowedPackages = [ pkgs.coreutils ];
  stateDirs = [ "$HOME/.test-state-dir" ];
  readOnlyDirs = [ "$HOME/.test-readonly-dir" ];
  extraEnv = { TEST_VAR = "test-value"; };
}
