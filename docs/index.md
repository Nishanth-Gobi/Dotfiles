# Dotfiles

Modern, XDG-compliant, modular configuration for macOS (Apple Silicon) and Linux VMs.
Built for speed, minimalism, and a "clean home" philosophy.

## Architecture

Each tool is a [GNU Stow](https://www.gnu.org/software/stow/) package: `<tool>/.config/<tool>/...`.
Running `stow <tool>` symlinks its contents into `$HOME`, keeping `$HOME` tidy and
configs colocated under `$XDG_CONFIG_HOME`.

```text
dotfiles/
├── home/.zshenv             # → ~/.zshenv
├── zsh/.config/zsh/         # → ~/.config/zsh/
├── nvim/.config/nvim/       # → ~/.config/nvim/
└── ...
```

## Quick start

```sh
git clone --recursive https://github.com/Nishanth-Gobi/Dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

See [Setup → macOS](setup/macos.md) for details.

## Module map

| Module | Purpose |
| --- | --- |
| [zsh](modules/zsh.md) | Shell, aliases, prompt, plugins |
| [nvim](modules/nvim.md) | LazyVim-based editor config |
| [git](modules/git.md) | Global git config, allowed signers |
| [kitty](modules/kitty.md) | Terminal emulator |
| [zed](modules/zed.md) | Zed editor settings & keymaps |
| [btop](modules/btop.md) | System monitor |
| [fastfetch](modules/fastfetch.md) | System info |
| [lazygit](modules/lazygit.md) | Git TUI |
| [aws](modules/aws.md) | AWS CLI config |
| [aerospace](modules/aerospace.md) | macOS tiling WM |
| [assets](modules/assets.md) | Wallpapers, terminal art |
