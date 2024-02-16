{
  description = "Homepage";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    dev.url = "github:dyercode/dev";
    cnt.url = "github:dyercode/cnt";
  };

  outputs = { self, nixpkgs, flake-utils, dev, cnt }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        inherit system;
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            yarn-berry
            elmPackages.elm-json
            podman
            buildah
            fish
            cnt.defaultPackage.${system}
            dev.packages.${system}.default
          ];

          shellHook = ''
            export RUNNER="podman"
            export BUILDER="buildah"
            export IMAGE="homepage"
          '';
        };
      });
}
