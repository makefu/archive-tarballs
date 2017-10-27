{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "archive-env";
  version = "1.0";
  buildInputs = with pkgs; [
    nix-prefetch-scripts

    # requires stockholm-krebs overlay:
    ## http://cgit.euer.krebsco.de/stockholm/tree/krebs/5pkgs
    internetarchive
    slog
  ];
  shellHook = ''
    HISTFILE=${builtins.toString ./.}/histfile
  '';
}
