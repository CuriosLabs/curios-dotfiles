---
name: curios-update
description: Manage CuriOS/NixOS system updates, package installations, and module configurations using the `curios-update` tool.
---

# Curios System Manager Skill

This skill provides a comprehensive interface for managing the CuriOS Linux system.
It leverages the `curios-update` utility to perform system-level operations.

## What I do

- **System Updates**: Update the entire system, including installed packages and
  Nix flakes, do a Nix garbage collector, using `sudo curios-update --update`.
- **System Upgrades**: Download and install the latest CuriOS system version using
  `sudo curios-update --upgrade`.
- **System modules/configuration**:
  - When installing a package or changing a system configuration, the FIRST thing
  to do is to verify if the package or the configuration is defined
  by a CuriOS modules with: `curios-update --show-modules`. This will return a
  JSON output. For example, the key "curios.virtualisation.docker.enable" tell
  us if "docker" and its dependencies are installed.
  - More information could be shown on a NixOS or a CuriOS option using
  `curios-update --nixos-option <option_key>`
  (i.e `curios-update --nixos-option curios.virtualisation.docker.enable`).
  - The CuriOS module could be set with:
  `sudo curios-update --update-modules <option_key> <value>`
  - After a module update, the system MUST be updated with:
  `sudo curios-update --update`
- **Package Management**: In last resort, packages could be installed as standard
  NixOS package if a CuriOS modules does NOT exist for it.
  - Search for NixOS packages name and information with:
  `curios-update --search-pkgs <name>`. Notice the 'package_attr_name' value
  of the JSON output.
  - Then install a NixOS package: `sudo curios-update --add-pkg <attr_name>`.

## When to use me

- When the user wants to update their system or installed packages.
- When a user needs to search for or install a new NixOS package.
- When modifying CuriOS-specific desktop or system modules (e.g., changing
  timezones, enabling browsers).
- When checking for system updates or upgrading to a new CuriOS release.
- When inspecting current NixOS or CuriOS configuration options.

## Important Notes

- **Discovery**: Use `curios-update --help` to explore the latest options
  and command syntax.
- Most modifying commands (update, upgrade, add-pkg, update-modules) require `sudo`.
- Always verify the package attribute name "package_attr_name" using `--search-pkgs`
  before attempting to install with `--add-pkg`.
- Updating a module (`--update-modules`) should typically be followed by a system
  update (`--update`) for changes to take effect.
