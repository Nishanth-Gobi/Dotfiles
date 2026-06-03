# Linux setup

Primary use case: VMs (Debian, Ubuntu, Arch). Tested where noted.

## Bootstrap

```sh
sudo apt-get install -y git stow zsh   # Debian/Ubuntu
# OR
sudo pacman -S --needed git stow zsh   # Arch

git clone --recursive https://github.com/Nishanth-Gobi/Dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

`install.sh` on Linux **skips** automatic package install — distro
fragmentation (pkg name differences between apt/pacman/dnf) is too
fragile to script reliably. Install packages by hand per distro.

## Suggested package list

Cross-platform CLI tools used by these dotfiles:

- `git`, `stow`, `zsh`, `neovim`
- `bat` (Debian: `batcat`)
- `tree`, `btop`, `fastfetch`
- `kitty`, `curl`, `unzip`

## macOS-only modules

`install.sh` skips `aerospace` and `raycast` on Linux automatically —
both are macOS-only apps.

## Stow conflicts

Identical behavior to macOS — see [macOS → Run order matters](macos.md#run-order-matters).
