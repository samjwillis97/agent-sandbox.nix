let
  pkgs = import <nixpkgs> { };
  sandbox = import ../../default.nix { pkgs = pkgs; };
  nonClosurePkg = pkgs.hello;
in sandbox.mkSandbox {
  pkg = pkgs.bashInteractive;
  binName = "bash";
  outName = "sandboxed-bash-nix-support";
  allowedPackages = [ pkgs.coreutils ];
  allowNix = true;
  env = {
    NIX_PATH = "nixpkgs=${pkgs.path}";
    NON_CLOSURE_STORE_PATH = "${nonClosurePkg}";
    # Flake CLI (nix build/run/develop) needs these experimental features. On
    # Linux /etc/nix is not visible inside the sandbox, so the client picks up
    # no global config and must be told here; this is the env.NIX_CONFIG
    # pattern the README documents for nix client config.
    NIX_CONFIG = "experimental-features = nix-command flakes";
  };
}
