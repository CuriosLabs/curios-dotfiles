# AI Agent Guide: CuriOS Dotfiles

This repository is the [CuriOS](https://github.com/CuriosLabs/CuriOS) package
that manages user dotfiles and themes for the
[COSMIC desktop environment](https://system76.com/cosmic/). It is pre-installed
with CuriOS.

It does **not** ship application configs. There is no `.config/`, `themes/`,
`wallpapers/`, `.agents/`, or `.pi/` tree here. Do not recreate them.

## Project Overview

- **Purpose**: Retrieve dotfiles from a Git repository (such as
  [curios-themes](https://github.com/CuriosLabs/curios-themes)), apply themes,
  and set the COSMIC keyboard layout.
- **Main logic**: The Bash script `curios-dotfiles`.
- **Packaging**: Nix (`default.nix`, `pkgs/curios-dotfiles/default.nix`).
- **Command runner**: `just`, always via the dev shell:
  `nix-shell shell.nix --run "just <recipe>"`.

## CLI

```
curios-dotfiles [options] <directory>
```

`<directory>` is where dotfiles are copied (`$HOME`, `/etc/skel`, …).
It must already exist. `--help`, `--version`, and `--list` exit before that
check.

| Option | Meaning |
| --- | --- |
| `-h`, `--help` | Print usage and exit. |
| `--lang LANG` | COSMIC keyboard layout. Default: `us`. |
| `--list` | List themes from the theme config and exit. |
| `--themes THEME` | Apply a theme, for example `One Dark`. |
| `-v`, `--verbose` | Print more information. |
| `--version` | Print the version and exit. |

Themes are read from `$HOME/.curios/themes/themes.json` (`THEME_CONFIG_FILE`),
not from this repository. `jq` is required to read that file.
`curios-dotfiles --list` prints the theme names.

```bash
curios-dotfiles --list
curios-dotfiles --themes "One Dark" "$HOME"
curios-dotfiles --lang fr --themes "One Dark" "$HOME"
sudo curios-dotfiles /etc/skel/
```

`--lang` is parsed, but the COSMIC layout write is currently commented out in
the script. Do not document it as applied until that line is restored.

## Repository Layout

- `curios-dotfiles`: the CLI.
- `justfile`: development recipes.
- `shell.nix`: `just`, `statix`, `shellcheck`, `fd`, `jq`, `git`, `gh`, `gnused`.
- `default.nix`: local entry point for `just build` and `just run`.
- `pkgs/curios-dotfiles/default.nix`: published package (version and source hash).

`just build` and `just run` fetch the GitHub tag in `default.nix`. They do not
run the working tree. `just test` runs `./curios-dotfiles` and forwards arguments.

## Key Workflows

### Changing the CLI

Edit `curios-dotfiles` only. Keep it `shellcheck`-clean: `readonly` for
constants, `local` for function variables.

### Themes

Add or edit themes in `$HOME/.curios/themes/themes.json` (or the
[curios-themes](https://github.com/CuriosLabs/curios-themes) repo), under
`.themes`. Each entry may set `alacritty_theme`, `ghostty_theme`, `zed`,
`color`, `herdr`, `nvim`, `tui`, `cosmic_theme`, and `wallpapers`. Paths may
start with `~/` and are expanded against the install directory (`cosmic_theme`
is expanded against `$HOME`).

`apply_theme` writes into the target directory for Alacritty, Ghostty,
OpenCode, Neovim, Herdr, Zed, Brave (`/etc/brave/policies/managed/themes.json`),
and COSMIC (appearance import and wallpaper RON files). It does not store those
files in this repo.

### Testing and release

```bash
nix-shell shell.nix --run "just lint"
nix-shell shell.nix --run "just test --help"
nix-shell shell.nix --run "just run"
nix-shell shell.nix --run "just publish <version>"
```

`just publish <version>` checks the tag out from `testing`, lints, tags, updates
the Nix hash, pushes, and opens a pull request against `main`.

## Technical Standards

- **Nix**: Lint with `statix`. The `installPhase` installs the script mode `555`
  and wraps it so `git`, `gnused`, and `jq` are on `PATH`. No data files are
  installed.
- **Bash**: Must pass `shellcheck`.
- **COSMIC**: Wallpaper state is RON (`Some("...")` / `source: Path("...")`).
  Do not add `.ron` themes to this repository.
