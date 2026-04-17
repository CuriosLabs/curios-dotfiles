---
name: curios-dotfiles
description:
 Install and manage CuriOS dotfiles, themes, and COSMIC desktop settings using
 the `curios-dotfiles` tool.
metadata:
  author: CuriosLabs
  version: "1.0.0"
---

# Curios Dotfiles Skill

This skill allows the agent to install and configure CuriOS-specific dotfiles
and themes for COSMIC desktop environment. It leverages the `curios-dotfiles`
utility.

## How to use it

1. **Determine language**: Ask user language or find the system language with the
   command: `curios-update --nixos-option curios.system.keyboard`.
2. **Deployment**: Deploy configurations to user $HOME directory or as a skeleton
   for future users using "/etc/skel/" directory.
3. **Dotfiles/Theme Application**: Apply a specific theme (e.g., One-Dark,
  Catppuccin-Macchiato, Tokyonight) and dotfiles using the command:
  `curios-dotfiles --lang <language> --themes <theme> <directory>`.

## When to use me

- When a user wants to install the CuriOS dotfiles in their home directory.
- When a user wants to change their overall system theme (colors for Alacritty,
  Neovim, Zed, etc.).
- When a user needs to set their COSMIC keyboard layout during dotfiles installation.
- When setting up a new environment or preparing a system skeleton.

## Important Notes

- **Discovery**: Use `curios-dotfiles --help` to check available themes and options.
- Available themes: `Catppuccin-Macchiato`, `Everforest-Medium`, `Gruvbox-Dark`,
  `Hackers-Green`, `Kanagawa`, `Nord-Dark`, `Nord-Light`, `One-Dark`, `Tokyonight`.
- Default keyboard layout is `us`.
- Default theme is `One-Dark`.
