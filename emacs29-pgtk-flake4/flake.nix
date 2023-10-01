{
  description = "emacs29-pgtk intended for DOOM Emacs";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";             # primary nixpkgs
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in with pkgs; rec {
        # Development environment
        devShell = mkShell {
          name = "DOOM emacs29-pgtk";
          nativeBuildInputs = [
	          ((emacsPackagesFor emacs29-pgtk).emacsWithPackages (epkgs: [epkgs.vterm]))
	          git
	          ripgrep
            bash
            coreutils
            openssh
            pinentry
            pinentry-curses
	    gnupg
	    nerdfonts
	    fzf
            nodejs
            pandoc
          ];
           shellHook = ''
             exec zsh
      export GPG_TTY=$(tty)
            echo "DOOOOM"
            #echo pinentry-program $(which pinentry-curses) >> ~/.gnupg/gpg-agent.conf
            echo pinentry-program $(which pinentry) >> ~/.gnupg/gpg-agent.conf
       '';
        };
      }
    );
}
