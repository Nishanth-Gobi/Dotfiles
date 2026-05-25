# Dotfiles

Modern, XDG-compliant, modular configuration for macOS (Apple Silicon)
and Linux VMs. Built for speed, minimalism, and a clean `$HOME`.

> 📖 **Full docs:** <https://dotfiles.nishanthgobi.com/>
>
> 🧭 **Editor spec:** [`docs/philosophy.md`](docs/philosophy.md) — portable source of truth for `nvim` + `zed` modules.

## Architecture

Each tool is a [GNU Stow](https://www.gnu.org/software/stow/) package laid
out as `<tool>/.config/<tool>/...`. Running `stow <tool>` symlinks its
contents into `$HOME`, keeping `$HOME` tidy and configs colocated under
`$XDG_CONFIG_HOME`.

## Quick start

```sh
git clone --recursive git@github.com:Nishanth-Gobi/Dotfiles.git ~/dotfiles/Dotfiles
cd ~/dotfiles/Dotfiles
./install.sh
```

`install.sh` installs Homebrew (macOS), runs `brew bundle`, initializes
zsh-plugin submodules, then `stow`s each module with dry-run conflict
detection. On Linux, package install is manual — see the
[Linux setup page](https://dotfiles.nishanthgobi.com/setup/linux/).

## Modules

| Module     | Purpose                                  | Scope    |
| ---------- | ---------------------------------------- | -------- |
| home       | `$HOME` entry points (`.zshenv`, etc.)   | both     |
| zsh        | Shell, aliases, prompt, plugins          | both     |
| git        | Personal git config + `includeIf` work   | both     |
| nvim       | LazyVim-based editor                     | both     |
| kitty      | Terminal emulator                        | both     |
| zed        | Zed editor settings + keymaps            | both     |
| btop       | System monitor                           | both     |
| fastfetch  | System info on shell startup             | both     |
| lazygit    | Git TUI                                  | both     |
| aws        | AWS CLI config (dummy creds)             | both     |
| assets     | Wallpapers, terminal art, ASCII          | both     |
| aerospace  | Tiling window manager                    | macOS    |
| raycast    | Launcher config export                   | macOS    |

## Secrets & machine-specific config

Anything that varies per machine (API tokens, Java home, Android SDK):
`~/.config/zsh/host.zsh`. Sourced by `.zshrc` if present, silently
skipped otherwise. Gitignored, never tracked.

Work git identity: `~/.config/git/work.local`. Auto-loaded by `includeIf`
for any repo under `~/work/`. Also machine-local. See the
[git module page](https://dotfiles.nishanthgobi.com/modules/git/)
for the full pattern.

## Maintenance

```sh
# Add a new module
mkdir -p mytool/.config/mytool
mv ~/.config/mytool/* mytool/.config/mytool/
stow -d ~/dotfiles/Dotfiles -t ~ mytool
# then add `mytool` to COMMON_MODULES in install.sh

# Update zsh plugin submodules
git submodule update --remote --merge

# Refresh Brewfile from current state
brew bundle dump --force --file=~/dotfiles/Dotfiles/Brewfile

# Re-link a module after editing the source
stow -d ~/dotfiles/Dotfiles -t ~ --restow zsh
```

## Local docs preview

```sh
python3 -m venv .venv-docs
.venv-docs/bin/pip install -r requirements-docs.txt
.venv-docs/bin/mkdocs serve   # http://127.0.0.1:8000/
```
