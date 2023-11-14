{
  description = "nix-doom-emacs shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
  };

  outputs = { self, nixpkgs, nix-doom-emacs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      doom-emacs = nix-doom-emacs.packages.${system}.default.override {
        doomPrivateDir = ~/doom-vertico-config;
      };
    in with pkgs;
      {
        devShells.${system}.default = pkgs.mkShell {
          name = "nix-doom-emacs (emacs29-pgtk)";
          nativeBuildInputs = [
            ((emacsPackagesFor emacs29-pgtk).emacsWithPackages (epkgs: [epkgs.vterm]))
            nerdfonts
            doom-emacs
            zsh
            git
            # ripgrep
            (ripgrep.override {withPCRE2 = true;})
            openssh
            nerdfonts
            nodejs
            pandoc
            fd
            p7zip
            yq
            jq
            zstd
            (aspellWithDicts (ds: with ds; [ en en-computers en-science ]))
            sqlite
            nil
          ];
          shellHook = ''
             exec zsh
       '';
        };
      };
}
