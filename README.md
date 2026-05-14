# 🛠️ .dotfiles

Modern, XDG-compliant, and modular configuration for macOS (Apple Silicon). Built for speed, minimalism, and a "clean home" philosophy.

## 🏗️ Architecture

This repository uses GNU Stow to manage symlinks. Instead of cluttering the $HOME directory, all configurations are consolidated into `~/.config` following the XDG Base Directory Specification.

**Modules:**

- `home/`: Critical entry points that must reside in `~/` (e.g., `.zshenv`, `.hushlogin`).
- `zsh/`: Core shell logic, aliases, and theme settings.
- `git/`: Global Git configuration and XDG-aware ignore rules.
- `kitty/`: Terminal emulator configuration.
- `assets/`: Wallpapers, ASCII art, and Kitty protocol terminal images.

---

## 🚀 Quick Start (New Machine)

To turn a fresh macOS install into a fully configured development environment:

```sh
git clone --recursive https://github.com/Nishanth-Gobi/Dotfiles.git ~/Dotfiles
cd ~/Dotfiles
chmod +x install.sh
./install.sh
```

---

## 🔒 Secrets & Machine-Specific Config

The `.zshrc` is designed to be portable and "logic-only." All secrets (NPM tokens, AWS keys) and machine-specific paths (Android SDK, Java Home) should live in:
`~/.config/zsh/host.zsh`

Note: This file is explicitly listed in `.gitignore` and will never be tracked in version control. If it doesn't exist on a new machine, the shell will load with a warning but won't crash.

---

## 🛠️ Maintenance

**Adding a new module:**

- Create a folder: `mkdir -p mytool/.config/mytool`
- Move your config there.
- Run `stow mytool` from the root.

**Updating zsh Plugins:**

Since plugins are tracked as Git Submodules:

```sh
git submodule update --remote --merge
```

**Brewfile:**

- To install everything: `brew bundle --file=~/dotfiles/Brewfile`
- To update the Brewfile: `brew bundle dump --force --file=~/dotfiles/Brewfile`

