{
  description = "ZuriHac 2026";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-26.05";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ self, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems =
        [ "x86_64-linux" "x86_64-darwin" "aarch64-darwin" "aarch64-linux" ];
      perSystem = { system, self', ... }:
        let
          # Pin GHC version for easier, explicit upgrades later
          ghcVersion = "9103";
          pkgs = import inputs.nixpkgs {
            inherit system;
            config.allowUnfree = true;
            overlays = [
              (_: prev: {
                haskellPackages = prev.haskell.packages."ghc${ghcVersion}";
              })
            ];
          };
          haskell-code = pkgs.haskellPackages.callCabal2nix "haskell-code"
            (pkgs.lib.cleanSource ./haskell-code) { };
        in {
          formatter = pkgs.nixfmt;
          devShells = {
            default = pkgs.haskellPackages.shellFor {
              packages = _: [ haskell-code ];
              nativeBuildInputs = [ pkgs.haskellPackages.doctest ];
              buildInputs = [
                pkgs.cabal-install
                self'.packages.hls
                self'.formatter
              ];
              shellHook = ''
                export PS1="\n\[\033[1;32m\][nix-shell:\W \[\033[1;31m\]ZuriHac\[\033[1;32m\]]\$\[\033[0m\] "
                echo -e "\n\033[1;31m ♣ ♠ Welcome to ZuriHac! ♥ ♦ \033[0m\n"
                echo -e "   Use the following command to open VSCode in this directory:\n"
                echo "       code ."
              '';
            };

            withVSCode = self.devShells.${system}.default.overrideAttrs (old:
              let
                vscode = pkgs.vscode-with-extensions.override {
                  vscodeExtensions = with pkgs.vscode-extensions; [
                    bbenoist.nix
                    haskell.haskell
                    justusadam.language-haskell
                  ];
                };
              in {
                buildInputs = old.buildInputs ++ [ vscode ];
                shellHook = old.shellHook + ''
                  echo -e "\n   All required extensions should be pre-installed and ready."'';
              });
          };

          packages = {
            inherit haskell-code;
            inherit (pkgs) cabal-install;

            hls = pkgs.haskell-language-server.override {
              supportedGhcVersions = [ ghcVersion ];
            };

          };
        };
    };
}
