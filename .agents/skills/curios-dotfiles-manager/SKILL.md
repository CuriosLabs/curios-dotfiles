---
name: curios-dotfiles-manager
description: Install and manage CuriOS dotfiles, themes, and COSMIC desktop settings using the `curios-dotfiles` tool.
---

# Curios Dotfiles Manager Skill

This skill allows the agent to install and configure CuriOS-specific dotfiles for
applications like Alacritty, btop, COSMIC, Neovim, and Zed.

## What I do

- **Dotfile Installation**: Install the complete set of CuriOS dotfiles into a specified
  directory (e.g., `$HOME` or `/etc/skel`) using `curios-dotfiles <directory>`.
- **Theme Application**: Apply a specific theme (e.g., One-Dark, Catppuccin-Macchiato,
  Tokyonight) during installation using the `--themes <THEME>` option.
- **Keyboard Layout Configuration**: Preset the COSMIC keyboard layout (e.g., us,
  fr, de) using the `--lang <LANG>` option.
- **Current Keyboard Layout**: Find the current keyboard with the command
  `curios-update --nixos-option curios.system.keyboard`.
- **Deployment**: Deploy configurations as a skeleton for future users using:
  `curios-dotfiles /etc/skel/`.

## When to use me

- When a user wants to install the CuriOS dotfiles in their home directory.
- When a user wants to change their overall system theme (colors for Alacritty,
  Neovim, Zed, etc.).
- When a user needs to set their COSMIC keyboard layout during dotfile installation.
- When setting up a new environment or preparing a system skeleton.

## Important Notes

- **Discovery**: Always use `curios-dotfiles --help` to check available themes
  and options.
- Available themes: `Catppuccin-Macchiato`, `Everforest-Medium`, `Gruvbox-Dark`,
  `Hackers-Green`, `Kanagawa`, `Nord-Dark`, `Nord-Light`, `One-Dark`, `Tokyonight`.
- Default keyboard layout is `us`.
- Default theme is `One-Dark`.
