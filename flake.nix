{
  description = "Nix C++ template";
  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; };
  outputs = { self, nixpkgs }:

  let
    allSystems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
    
    forAllSystems = fn: nixpkgs.lib.genAttrs allSystems 
      ( system: 
        let
          pkgs = import nixpkgs {
            inherit system;
          };

          nativeBuildInputs = with pkgs; [
            cmake
            clang-tools_16
            gtest
            #lldb_16
            mold
            ninja
            pkg-config
            #valgrind
          ];

          buildInputs = with pkgs; [
            spdlog
          ];
      in
      with pkgs;
      {
        #devShells.default = forAllSystems ( { pkgs } : {
          devShells.default = pkgs.mkShell rec {
            name = "NixCppTempl";
            inherit buildInputs nativeBuildInputs;

            KEY = "value";
            shellHook = ''
              export PS1="${name}"
            '';
          }; # devShell 
        #}); # devShells
        }
      );
    
}

