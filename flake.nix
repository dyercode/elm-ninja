{
  description = "Homepage";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            nodePackages.yarn
            elmPackages.elm-json
            elmPackages.elm-format
            elmPackages.elm-test
            podman
            buildah
          ];

          shellHook = ''
            export RUNNER="podman"
            export BUILDER="buildah"
          '';
        };
      });
}
