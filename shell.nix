{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    # For justfile
    statix
    shellcheck
    fd
    just
    git
  ];
}


