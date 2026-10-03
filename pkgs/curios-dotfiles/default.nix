# CuriOS dotfiles packages.
# Set COSMIC, ZSH and various configuration files.

{ lib, pkgs, stdenvNoCC, fetchFromGitHub }:
stdenvNoCC.mkDerivation rec {
  pname = "curios-dotfiles";
  version = "0.40.0";

  src = fetchFromGitHub {
    owner = "CuriosLabs";
    repo = "curios-dotfiles";
    rev = version;
    hash = "sha256-SxVVFtxdPdfZlKZELoiar7lVKCaVSiaHcmb2Slz3Yzs=";
  };

  buildInputs = [ pkgs.git pkgs.gnused pkgs.jq ];

  dontPatch = true;
  dontConfigure = true;
  dontBuild = true;
  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin/

    install -D -m 555 -t $out/bin/ curios-dotfiles

    runHook postInstall
  '';

  meta = {
    description = "COSMIC Desktop Environment configuration files for CuriOS";
    homepage = "https://github.com/CuriosLabs/curios-dotfiles";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
  };
}
