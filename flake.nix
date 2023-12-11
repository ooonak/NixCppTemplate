{
  description = "Nix C++ template";
  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; };
  outputs = { self, nixpkgs }:

    let
      #allSystems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      allSystems = [ "x86_64-linux" ];

      forAllSystems = func: nixpkgs.lib.genAttrs allSystems
        (system: func nixpkgs.legacyPackages.${system});

    in
    {

      packages = forAllSystems (pkgs: {
        default = pkgs.callPackage ./package.nix { };
      });

    };
}

