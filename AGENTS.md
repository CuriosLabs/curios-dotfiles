# AI Agent Guide: CuriOS Dotfiles

This repository is the [CuriOS](https://github.com/CuriosLabs/CuriOS) package
that manages user dotfiles and themes for the
[COSMIC desktop environment](https://system76.com/cosmic/). It is pre-installed
with CuriOS.

It does **not** ship application configs. There is no `.config/`, `themes/`,
`wallpapers/`, `.agents/`, or `.pi/` tree here. Do not recreate them.

## Project Overview

- **Purpose**: Clone dotfiles, themes, and wallpapers from a Git repository
  (such as [curios-themes](https://github.com/CuriosLabs/curios-themes)) with
  `--upgrade`, apply a theme, and set the COSMIC keyboard layout.
- **Main logic**: The Bash script `curios-dotfiles`.
- **Packaging**: Nix (`default.nix`, `pkgs/curios-dotfiles/default.nix`).
- **Command runner**: `just`, always via the dev shell:
  `nix-shell shell.nix --run "just <recipe>"`.

## CLI

```
curios-dotfiles [options] <directory>
```

`<directory>` is where dotfiles are copied (`$HOME`, `/etc/skel`, …).
It must already exist. `--help`, `--version`, `--list`, and `--info` exit
before that check. `--upgrade` does not.

| Option | Meaning |
| --- | --- |
| `-h`, `--help` | Print usage and exit. |
| `--info` | Print the Git URL, branch, and revision, then exit. |
| `--lang LANG` | COSMIC keyboard layout. Default: `us`. |
| `--list` | List themes from the theme config and exit. |
| `--themes THEME` | Apply a theme, for example `One Dark`. |
| `--upgrade` | Clone the configured Git repository and copy it into `<directory>`. |
| `-v`, `--verbose` | Print more information. |
| `--version` | Print the version and exit. |

Themes are read from `$HOME/.curios/themes/themes.json` (`THEME_CONFIG_FILE`),
not from this repository. `jq` is required to read that file.
`curios-dotfiles --list` prints the theme names.

```bash
curios-dotfiles --list
curios-dotfiles --info
curios-dotfiles --upgrade "$HOME"
curios-dotfiles --themes "One Dark" "$HOME"
curios-dotfiles --lang fr --themes "One Dark" "$HOME"
sudo curios-dotfiles --upgrade /etc/skel/
```

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

### Dotfiles and `--upgrade`

This repository does not contain the dotfiles. `--info` and `--upgrade` read
the source from the running NixOS configuration:

- `curios.core.dotfiles.url`
- `curios.core.dotfiles.branch`
- `curios.core.dotfiles.revision`

`--upgrade` clones `url` at `branch` (`--single-branch --depth 1`) into a
temporary directory and deletes that clone on exit. It does not check out
`revision`. `verify_commit_signature` exists but is not called.

The clone must contain `dotfiles/`, `themes/themes.json`, and `wallpapers/`.
Otherwise the script exits with `Not a valid CuriOS theme!`.

| Source | Destination |
| --- | --- |
| `dotfiles/` | `<directory>/`, including hidden files |
| `themes/` | `<directory>/.curios/themes/` |
| `wallpapers/` | `<directory>/.curios/wallpapers/` |

Only `.jpg`, `.jpeg`, and `.png` files are copied from `wallpapers/`.
Subdirectories are kept. `cp -a` overwrites existing files and does not delete
anything else. `--upgrade` does not apply a theme. If `--themes` is also
passed, the upgrade runs first.

`--list` and `--themes` always read `$HOME/.curios/themes/themes.json`, not
`<directory>`. Upgrading `/etc/skel` does not change the current user's theme
list.

To use another repository, set `curios.core.dotfiles.url` (an SSH URL for a
private repo; do not put a token in the option) and optionally `.branch` with
`curios-update`, run `curios-update --update`, then
`curios-dotfiles --upgrade <directory>`. The user who runs `--upgrade` must
already be able to clone that URL.

### Themes

Add or edit themes in `$HOME/.curios/themes/themes.json` (or the
[curios-themes](https://github.com/CuriosLabs/curios-themes) repo), under
`.themes`. Each entry may set `alacritty_theme`, `ghostty_theme`, `zed`,
`color`, `nvim`, `cosmic_theme`, and `wallpapers`. A path that starts with
`~`, `$HOME`, or `${HOME}` is expanded against the install directory.
Anything else is left unchanged.

`apply_theme` writes into the target directory for Alacritty, Ghostty,
Neovim, Zed, Brave (`/etc/brave/policies/managed/themes.json`),
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
