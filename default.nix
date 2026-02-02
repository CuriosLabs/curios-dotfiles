{ pkgs ? import <nixpkgs> {} }:
pkgs.callPackage ./pkgs/curios-dotfiles {}

# test it locally with `just run`.
