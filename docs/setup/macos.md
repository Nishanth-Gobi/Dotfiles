# macOS setup

Apple Silicon Macs. Tested on macOS 14+.

## One-shot bootstrap

```sh
git clone --recursive https://github.com/Nishanth-Gobi/Dotfiles.git ~/dotfiles/Dotfiles
cd ~/dotfiles/Dotfiles
./install.sh
```

`install.sh` will:

1. Install Homebrew if missing.
2. `brew bundle` the [Brewfile](https://github.com/Nishanth-Gobi/Dotfiles/blob/main/Brewfile).
3. `git submodule update --init --recursive` for zsh plugins.
4. `mkdir -p ~/.config`.
5. Dry-run `stow` each module; abort on conflict.
6. `stow --restow` each module (idempotent).

## Run order matters

Run `install.sh` **before** launching any app whose config it manages
(Aerospace, Kitty, Zed, etc.). If the app launches first, it creates a
default config in `~/.config/<app>/`, which collides with stow.

If you hit a conflict:

```sh
# Move existing file aside
mv ~/.config/kitty/kitty.conf ~/.config/kitty/kitty.conf.bak

# Re-run install
./install.sh
```

## Manual rerun for one module

```sh
cd ~/dotfiles/Dotfiles
stow -d . -t ~ --restow kitty
```

## Secrets

Anything machine-specific (API tokens, Java home, Android SDK) goes in
`~/.config/zsh/host.zsh`. That file is gitignored. `.zshrc` sources it
if present, skips silently otherwise.

## Brewfile update

```sh
brew bundle dump --force --file=~/dotfiles/Dotfiles/Brewfile
```
