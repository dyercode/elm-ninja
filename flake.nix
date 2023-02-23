{
  description = "Homepage";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    cnt.url = "github:dyercode/cnt";
  };

  outputs = { self, nixpkgs, flake-utils, cnt }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        inherit system;
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            nodePackages.yarn
            elmPackages.elm-json
            podman
            buildah
            fish
            cnt.defaultPackage.${system}
          ];

          shellHook = ''
            export RUNNER="podman"
            export BUILDER="buildah"
            export IMAGE="homepage"
          '';
        };
      });
}
