{
  description = "Homepage";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    dev.url = "github:dyercode/dev";
    cnt.url = "github:dyercode/cnt";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      dev,
      cnt,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        inherit system;
        devShells.default = pkgs.mkShell {
          nativeBuildInputs =
            with pkgs;
            [
              yarn-berry
              elmPackages.elm
              elmPackages.elm-json
              elmPackages.elm-coverage
              elmPackages.elm-format
              elmPackages.elm-test
              elmPackages.elm-review
              podman
              buildah
              fish
              scorecard
            ]
            ++ (map (x: x.packages.${system}.default) [
              dev
              cnt
            ]);

          shellHook = ''
            export RUNNER="podman"
            export BUILDER="buildah"
            export IMAGE="homepage"
          '';
        };
      }
    );
}
