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

### From the TUI

1. Open `curios-manager` (Shortcut: `Super+Return`).
2. Go to the `Themes` menu, then choose a theme from the list.

### From the CLI

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

## Custom dotfiles and themes

The default source is [curios-themes](https://github.com/CuriosLabs/curios-themes.git).
To use your own dotfiles or themes, point CuriOS at your Git repository, then
upgrade. A private repository must use an SSH URL, such as
`git@github.com:user/repo.git`. `curios-dotfiles` clones with the SSH keys of
the user who runs `--upgrade`. Do not put a token in the NixOS option.

That user must be able to clone the repository before running `--upgrade`.
For an SSH URL, add a host entry in `$HOME/.ssh/config` and register the
matching public key on the Git host:

```text
Host github.com
  User git
  IdentityFile ~/.ssh/id_ed25519
  IdentitiesOnly yes
```

On GitHub, `gh auth login` can create or upload that key.
See [Github auth login documentation](https://cli.github.com/manual/gh_auth_login).

```bash
sudo curios-update --update-module curios.core.dotfiles.url "git@github.com:user/repo.git"
sudo curios-update --update-module curios.core.dotfiles.branch "main"
sudo curios-update --update
curios-dotfiles --upgrade "$HOME"
```

`curios.core.dotfiles.branch` is optional. It defaults to `main`.
`--update` is required: `curios-dotfiles` reads the options from the running
system configuration.

The repository must contain `dotfiles/`, `themes/themes.json`, and `wallpapers/`.
`--upgrade` copies those trees into the given directory and replaces files that
already exist. It does not delete anything else.

| Source | Destination |
| --- | --- |
| `dotfiles/` | the install directory (`$HOME`, `/etc/skel`, …), including hidden files |
| `themes/` | `$HOME/.curios/themes/` |
| `wallpapers/` | `$HOME/.curios/wallpapers/` |

Only `.jpg`, `.jpeg`, and `.png` files are copied from `wallpapers/`. Other
files, such as `LICENSE.txt`, are skipped. Subdirectories are kept.

`themes/themes.json` lists the themes shown by `--list`. Each entry may set
`alacritty_theme`, `ghostty_theme`, `zed`, `color`, `nvim`, `cosmic_theme`,
and `wallpapers`. A path that starts with `~/` or `$HOME` is expanded against the
install directory.

```text
.
├── dotfiles/
│   ├── .zshrc
│   └── .config/
│       ├── alacritty/
│       │   └── One-Dark.toml
│       └── ghostty/
│           └── One-Dark.config
├── themes/
│   ├── themes.json
│   └── One-Dark.ron
└── wallpapers/
    └── one-dark/
        └── wallpaper.jpg
```

```json
{
  "version": "0.4",
  "themes": {
    "One Dark": {
      "alacritty_theme": "$HOME/.config/alacritty/One-Dark.toml",
      "ghostty_theme": "$HOME/.config/ghostty/One-Dark.config",
      "zed": "One-Dark",
      "color": "#20252c",
      "nvim": "onedark",
      "cosmic_theme": "$HOME/.curios/themes/One-Dark.ron",
      "wallpapers": "$HOME/.curios/wallpapers/one-dark/"
    }
  }
}
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
