# CuriOS dotfiles packages.
# Set COSMIC, ZSH and various configuration files.

{ lib, pkgs, stdenvNoCC, fetchFromGitHub }:
stdenvNoCC.mkDerivation rec {
  pname = "curios-dotfiles";
  version = "0.36.2";

  src = fetchFromGitHub {
    owner = "CuriosLabs";
    repo = "curios-dotfiles";
    rev = version;
    hash = "sha256-/KpScpAw9kKBPmamVtHAyxyuD1DH0ShZJ1OgXk75+Gw=";
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
