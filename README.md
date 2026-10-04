# Curi*OS* dotfiles manager

This is the [Curi*OS*](https://github.com/CuriosLabs/CuriOS) package to manage dotfiles
and set up themes for the [COSMIC desktop environment](https://system76.com/cosmic/).

## Installation

It comes pre-installed with [CuriOS](https://github.com/CuriosLabs/CuriOS).

## Features

- Retrieve user dotfiles from a Git repository, such as [Curi*OS* themes](https://github.com/CuriosLabs/curios-themes).
- Manage themes for the COSMIC desktop environment and tools such as Alacritty,
  Ghostty, Neovim, and Brave.
- Change the language setup on COSMIC.

## Usage

- Read the manual:

  ```bash
  curios-dotfiles --help
  ```

- List all available themes:

  ```bash
  curios-dotfiles --list
  ```

- Install the "One Dark" theme:

  ```bash
  curios-dotfiles --themes "One Dark" "$HOME"
  ```

- Set COSMIC for a French keyboard and Tokyo Night theme:

  ```bash
  curios-dotfiles --lang fr --themes "Tokyo Night" "$HOME"
  ```

## Build, Test, and Development Commands

This project uses [Just](https://github.com/casey/just) to manage development commands.
Enter the development shell first with `nix-shell shell.nix`.

- **Lint Files**: Check code quality for Nix and Bash files:

  ```bash
  nix-shell shell.nix --run "just lint"
  ```

- **Test Application**: Launch the `curios-dotfiles` CLI:

  ```bash
  nix-shell shell.nix --run "just test"
  ```

- **Publish a new version**: Create a new Git tag, push it, build it, and update
  the hash signature for the Nix package:

  ```bash
  nix-shell shell.nix --run "just publish 0.1.2"
  ```

- **Run**: Build the Nix package (from GitHub) and run it:

  ```bash
  nix-shell shell.nix --run "just run"
  ```

- **Clean**: Remove build artifacts:

  ```bash
  nix-shell shell.nix --run "just clean"
  ```
