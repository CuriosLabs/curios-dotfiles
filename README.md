# Curi*OS* dotfiles manager

This is [Curi*OS*](https://github.com/CuriosLabs/CuriOS) package to manage dotfiles
and setup themes for a [COSMIC desktop environment](https://system76.com/cosmic/).

## Installation

It comes pre-installed with [CuriOS](https://github.com/CuriosLabs/CuriOS).

## Features

- Retrieve user dotfiles from Git repository like [Curi*OS* themes](https://github.com/CuriosLabs/curios-themes).
- Manage themes for COSMIC Desktop environment and various tools like Alacritty,
  Ghostty, Herdr, OpenCode, NeoVim, Brave browser...
- Change language setup on COSMIC.

## Usage

- Read the manual:

```bash
  curios-dotfiles --help
  ```

- List all themes available:

  ```bash
  curios-dotfiles --list
  ```

- Install "One Dark" theme:

  ```bash
  curios-dotfiles --themes "One Dark" $HOME
  ```

## Build, Test, and Development Commands

This project uses [Just](https://github.com/casey/just) to manage development commands.
Use the appropriate shell environment before with `nix-shell shell.nix`.

- **Lint Files**: Check code quality for Nix and Bash files:

  ```bash
  nix-shell shell.nix --run "just lint"
  ```

- **Test Application**: Launch the `curios-dotfiles` CLI:

  ```bash
  nix-shell shell.nix --run "just test"
  ```

- **Publish a new version**: Create a new git tag, push it, build it and update
the hash signature for the Nix package:

  ```bash
  nix-shell shell.nix --run "just publish 0.1.2"
  ```

- **Run**: Build the Nix package (from Github) and run it:

  ```bash
  nix-shell shell.nix --run "just run"
  ```

- **Clean**: Remove build artifacts:

  ```bash
  nix-shell shell.nix --run "just clean"
  ```
