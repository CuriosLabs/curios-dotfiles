---
name: curios-update
description:
  Manage CuriOS a Linux distribution based on NixOS. Use when the user asks to do
  a system update or upgrade, add a package, change a module configuration.
---

# Curios System Manager Skill

This skill provides a comprehensive interface for managing the CuriOS Linux system.
It leverages the `curios-update` utility to perform system-level operations.

## What I do

- **System Update**: Update the entire system, including installed packages and
  Nix flakes, do a Nix garbage collector, using `sudo curios-update --update`.
- **System Upgrade**:
  1. Check if a newer version of Curios is available with: `curios-update --check`.
  2. If so, upgrade with: `sudo curios-update --upgrade`.
- **System modules/configuration**: CuriOS use a NixOS modular configuration. Many
  packages or configurations are defined as modules but not enabled by default.
  1. Verify if the package or the configuration is defined by a CuriOS module.
     As the output is JSON, use `grep` or `jq` to find the path of an option:
     - Search with grep: `curios-update --show-modules | grep -i "docker"`
     - Search (firefox in this example) the JSON path with jq:
       `curios-update --show-modules | jq -r 'paths | select(.[-1] == "firefox") | join(".")'`
  2. More information could be shown on a NixOS or a CuriOS option using:
     `curios-update --nixos-option <option_key>`
     (i.e `curios-update --nixos-option curios.virtualisation.docker.enable`).
  3. The CuriOS module or configuration could be set with:
     `sudo curios-update --update-modules <option_key> <value>`
  4. Then the system MUST be updated with: `sudo curios-update --update`.
- **Package Management**: In last resort, packages could be installed as standard
  NixOS package ONLY if a CuriOS modules does NOT exist for it.
  1. Search for NixOS packages attribute name and information with:
     `curios-update --search-pkgs <name>`. Notice the 'package_attr_name' value
     of the JSON output.
  2. Then install the NixOS package: `sudo curios-update --add-pkg <attr_name>`.

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
