{
  inputs.agent-sandbox.url = "github:archie-judd/agent-sandbox.nix";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { nixpkgs, agent-sandbox, ... }:
    let
      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
    in
    {
      devShells = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { system = system; };
          sbx = agent-sandbox.lib.${system};
          copilot-sandboxed = sbx.mkSandbox {
            pkg = pkgs.github-copilot-cli;
            binName = "copilot";
            outName = "copilot-sandboxed"; # or whatever alias you'd like
            allowedPackages = sbx.commonTools;
            stateDirs = [
              "$HOME/.config/github-copilot"
              "$HOME/.copilot"
            ];
            stateFiles = [ ];
            extraEnv = {
              # Pass secrets as shell variable references (e.g. "$TOKEN"), not
              # via builtins.getEnv, so they expand at runtime and stay out of
              # the /nix/store.
              GITHUB_TOKEN = "$GITHUB_TOKEN";
              GIT_AUTHOR_NAME = "copilot";
              GIT_AUTHOR_EMAIL = "copilot@localhost";
              GIT_COMMITTER_NAME = "copilot";
              GIT_COMMITTER_EMAIL = "copilot@localhost";
            };
            restrictNetwork = true;
            allowedDomains = {
              "githubcopilot.com" = "*";
              "github.com" = "*";
              "githubusercontent.com" = [
                "GET"
                "HEAD"
              ];
            };
          };
        in
        {
          default = pkgs.mkShell { packages = [ copilot-sandboxed ]; };
        }
      );
    };
}
