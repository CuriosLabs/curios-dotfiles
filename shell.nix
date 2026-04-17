{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    # For justfile
    statix
    shellcheck
    fd
    just
    git
    # Node.js environment
    nodejs_24
    typescript
  ];

  shellHook = ''
    # Ensure the local npm prefix from .npmrc is in the PATH
    export PATH="$HOME/.npm-packages/bin:$PATH"

    echo "❄️ CuriOS Dotfiles Dev Shell"
    echo "Note: Ensure '@opencode-ai/plugin', '@mariozechner/pi-coding-agent' and 'typescript-eslint' are installed via npm for full linting."
  '';
}


