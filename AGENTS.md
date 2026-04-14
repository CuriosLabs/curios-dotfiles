# AI Agent Guide: CuriOS Dotfiles

This repository contains the opinionated configuration files (dotfiles) for the
**CuriOS** Linux distribution, which is based on **NixOS** and uses the
**COSMIC Desktop Environment**.

## Project Overview

- **Purpose**: Manage and deploy configuration for COSMIC, Alacritty, btop,
  Neovim, Zed, and other desktop tools.
- **Main Logic**: A Bash script named `curios-dotfiles` handles the installation
  and theme application.
- **Packaging**: Nix is used for package management and environment
  reproducibility.
- **Command Runner**: `just` is used for development tasks (linting, testing,
  publishing).

## Core Components

- `.config/`: Contains the actual configuration files for various applications.
  - `alacritty/`: Terminal themes and main config.
  - `cosmic/`: Detailed COSMIC desktop settings (mostly RON files).
  - `nvim/`: Neovim configuration (LazyVim based).
  - `zed/`: Zed editor settings and themes.
  - `opencode/`: Opencode AI agent configuration.
- `.agents/`: Contains AI agents skills (procedural knowledge).
- `.gemini/`: Contains Gemini CLI configuration, agents and hooks.
- `.pi/`: Contains Pi coding agent configuration, extensions and themes.
- `themes/`: Predefined COSMIC desktop themes in `.ron` format.
- `wallpapers/`: Default CuriOS wallpapers.
- `curios-dotfiles`: The primary installation and management script.
- `pkgs/curios-dotfiles/default.nix`: The Nix expression that packages these
  dotfiles.

## Development Environment

- **shell.nix**: Provides all necessary dependencies (just, statix, shellcheck,
  etc.) to run the project's recipes.
- **Usage**: Always run just commands within the nix-shell environment for
  consistency:
  `nix-shell shell.nix --run "just <recipe_name>"`

## Key Workflows for AI Agents

### 1. Modifying Configurations

When asked to change a setting for a specific application:

- Locate the relevant file in `.config/<app>/`.
- Apply the change.
- If the change should be reflected immediately in a new installation, ensure it
  doesn't conflict with the `apply_theme` logic in `curios-dotfiles`.

### 2. Adding a New Theme

To add a new theme (e.g., "MyNewTheme"):

1. Create `themes/MyNewTheme.ron`.
2. Add any application-specific theme files (e.g.,
   `.config/alacritty/MyNewTheme.toml`).
3. Update the `THEMES_LIST` and `apply_theme` function in the `curios-dotfiles`
   script.
4. Ensure appropriate mappings for Neovim colorschemes and Zed themes are added
   to the `case` statement in `apply_theme`.

### 3. Testing Changes

- Use `nix-shell shell.nix --run "just lint"` to check Nix and Bash files.
- Use `nix-shell shell.nix --run "just test"` to run the `curios-dotfiles` script
  locally.
- Use `nix-shell shell.nix --run "just build"` to verify the Nix package builds
  correctly.

### 4. Releasing a New Version

- The `nix-shell shell.nix --run "just publish <version>"` command automates the
  tagging and hash update process for the Nix package.

## Technical Standards

- **Nix**: Use `statix` for linting. Follow standard NixOS packaging
  conventions.
- **Bash**: The `curios-dotfiles` script should be compatible with
  `shellcheck`. Use `readonly` for constants and `local` for function variables.
- **COSMIC Themes**: COSMIC uses the [RON (Rusty Object Notation)](https://github.com/ron-rs/ron)
  format for its configuration. Ensure correct syntax when editing `.ron` files.
- **File Permissions**: The Nix `installPhase` sets specific permissions (e.g.,
  `555` for binaries, `644` or `444` for data files).

## Important Context

The `curios-dotfiles` script expects to find its data in a `share` directory
relative to its installation path (usually provided by the Nix store). When
running locally for testing, it may behave differently unless the
`curios_dotfiles_path` is correctly resolved.
