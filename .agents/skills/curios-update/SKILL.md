---
name: curios-update
description:
  Manage CuriOS a Linux distribution based on NixOS. Use when the user asks to do
  a system update or upgrade, add a package, check if a package is installed,
  change or check a system or module configuration.
metadata:
  author: CuriosLabs
  version: "1.0.1"
---

# Curios System Manager Skill

This skill provides a comprehensive interface for managing the CuriOS Linux system.
It leverages the `curios-update` utility to perform system-level operations.
CuriOS follows a highly modular architecture, leveraging Nix modules to define
its system configuration.

## Quick reference

> **Note**: Most modifying commands (update, upgrade, add-pkg, update-module)
> require `sudo`.

| Task | Command |
|------|---------|
| Update the whole system | `sudo curios-update --update` |
| Check if a new version of the distribution is available | `curios-update --check` |
| Upgrade to the latest distribution version | `sudo curios-update --upgrade` |
| Search for a CuriOS module | `curios-update --search-modules <name>` |
| Query a NixOS/CuriOS option | `curios-update --nixos-option <key>` |
| Update a CuriOS module setting | `sudo curios-update --update-module <key> <value>` |
| Show all module settings | `curios-update --show-modules` |
| Search for a NixOS package | `curios-update --search-pkgs <name>` |
| Install a NixOS package | `sudo curios-update --add-pkg <attr_name>` |

## Common workflows

### Update the system

Update the entire system, all packages and Nix flakes and do a Nix garbage collector:

```bash
sudo curios-update --update
```

### Upgrade the system

Check if a new version of CuriOS is available, if so upgrade:

```bash
curios-update --check
sudo curios-update --upgrade
```

### System modules and configuration

When installing or checking a package, **FIRST** it **MUST** be verify if the package
is defined as a CuriOS **module**. This modules are defined as JSON key, i.e:
"curios.desktop.browser.firefox.enable" for the Firefox package, this key will be
used as a parameter for the `--update-module` and `--nixos-option` options.

```bash
# Search for the module key by name, JSON output choose the leaf key not the branch.
curios-update --search-modules <name>
# Query the module option to know more (works for any NixOS option too)
curios-update --nixos-option <key>
# Change the module setting
sudo curios-update --update-module <key> <value>
# you MUST update the system after a setting change
sudo curios-update --update
```

All modules can be shown (JSON output) with:

```bash
curios-update --show-modules
```

As a last resort, **IF** a package does **NOT** exist as a CuriOS module, it
should be searched and installed as a regular NixOS package:

```bash
# Notice the 'package_attr_name' value of the JSON output, first result should be the best match
curios-update --search-pkgs <name>
# Also notice the 'package_programs' value is an JSON array of programs provided by this package.
# Pass the 'package_attr_name' as a parameter
sudo curios-update --add-pkg <pkg_attr_name>
```

## When to use me

- When the user wants to update their system or install a package.
- When a user needs to search for or install a new NixOS package.
- When modifying CuriOS-specific desktop or system modules (e.g., changing
  timezones, enabling browsers).
- When checking for system updates or upgrading to a new CuriOS release.
- When inspecting current NixOS or CuriOS configuration options.

## Important Notes

- **Discovery**: Use `curios-update --help` to explore the latest options
  and command syntax.
