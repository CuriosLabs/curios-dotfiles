# CuriOS dotfiles

This is CuriOS opinionated configurations files to set up a [COSMIC desktop
environment](https://system76.com/cosmic/). It runs on a NixOS Linux distribution
set-up as [CuriOS](https://github.com/CuriosLabs/CuriOS).
![CuriOS desktop](https://github.com/CuriosLabs/CuriOS/blob/testing/img/Tiles.png?raw=true "CuriOS = NixOS + COSMIC DE")

## Installation

Those dotfiles are meant to be installed as a NixOS package. See
`pkgs/curios-dotfiles/default.nix`. It comes pre-installed with [CuriOS](https://github.com/CuriosLabs/CuriOS).

## Features

- COSMIC Desktop environment configuration files.
- Alacritty terminal theme.
- `btop` custom configuration.
- LazyVim default starter configuration files.
- npm user configuration file.

## Build, Test, and Development Commands

This project uses [Just](https://github.com/casey/just) to manage development commands.
Use the appropriate shell environment before with `nix-shell shell.nix`.

- **Lint Files**: Check code quality for Nix and Bash files:

  ```bash
  just lint
  ```

- **Test Application**: Launch the `curios-dotfiles` CLI:

  ```bash
  just test
  ```

- **Publish a new version**: Create a new git tag, push it, build it and update
the hash signature for the Nix package:

  ```bash
  just publish 0.1.2
  ```

- **Run**: Build the Nix package (from Github) and run it:

  ```bash
  just run
  ```

- **Clean**: Remove build artifacts:

  ```bash
  just clean
  ```

- **Supported Version**: NixOS 25.11 or later.

