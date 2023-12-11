{
  description = "Nix C++ template";
  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; };
  outputs = { self, nixpkgs, ... }:

    let
      #allSystems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      allSystems = [ "x86_64-linux" ];

      forAllSystems = func: nixpkgs.lib.genAttrs allSystems
        (system: func nixpkgs.legacyPackages.${system});

    in
    {

      packages = forAllSystems (pkgs: {
        default = pkgs.callPackage ./package.nix { };
        clang = pkgs.callPackage ./package.nix { stdenv = pkgs.clang16Stdenv; };
        gcc = pkgs.callPackage ./package.nix { stdenv = pkgs.gccStdenv; };

        dockerImage = pkgs.dockerTools.buildImage {
          name = "CppTemplAppContainer";
          created = "now";
          tag = builtins.substring 0 9 (self.rev or "dev");
          copyToRoot = pkgs.buildEnv {
            paths = with pkgs; [
              #self.packages.default
              #binSh
              #fakeNss
              #cacert
              #coreutils
              #bash
            ];
            name = "cpptemplapp-root";
            pathsToLink = [ "/bin" "/lib" "/include" ];
          };
          config = {
            Cmd = [ "bin/CppTemplApp" ];
            Env = [
              #"SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
              #"SYSTEM_CERTIFICATE_PATH=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
            ];
            #User = "nobody";
            #ExposedPorts = { "8000/tcp" = {}; };
            #WorkingDir = "/data";
            #Volumes = { "/data" = { }; };
          };
        };

      });

    };
}

