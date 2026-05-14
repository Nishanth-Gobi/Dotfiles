#!/usr/bin/env bash
# Bootstrap dotfiles on a fresh macOS or Linux machine.
# Idempotent: safe to re-run.

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

# --- Detect OS ---
case "$OSTYPE" in
  darwin*) OS="macos" ;;
  linux*)  OS="linux" ;;
  *) echo "Unsupported OS: $OSTYPE" >&2; exit 1 ;;
esac
echo "==> Detected: $OS"

# --- Install package manager + packages ---
if [[ "$OS" == "macos" ]]; then
  if ! command -v brew >/dev/null 2>&1; then
    echo "==> Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  echo "==> Syncing Brewfile"
  brew bundle --file="$DOTFILES_DIR/Brewfile"
elif [[ "$OS" == "linux" ]]; then
  echo "==> Linux: skipping auto package install (install manually, see README)."
fi

# --- Ensure stow ---
if ! command -v stow >/dev/null 2>&1; then
  echo "ERROR: GNU stow missing. Install it then re-run." >&2
  exit 1
fi

# --- Init submodules (zsh plugins) ---
echo "==> Updating git submodules"
git -C "$DOTFILES_DIR" submodule update --init --recursive

# --- Ensure ~/.config exists ---
mkdir -p "$HOME/.config"

# --- Modules ---
COMMON_MODULES=(home zsh git kitty nvim btop fastfetch fish assets aws alacritty zed lazygit)
MACOS_MODULES=(aerospace raycast)

MODULES=("${COMMON_MODULES[@]}")
[[ "$OS" == "macos" ]] && MODULES+=("${MACOS_MODULES[@]}")

# --- Stow ---
echo "==> Stowing modules: ${MODULES[*]}"
for module in "${MODULES[@]}"; do
  if [[ ! -d "$DOTFILES_DIR/$module" ]]; then
    echo "  skip $module (missing)"
    continue
  fi
  if ! stow -d "$DOTFILES_DIR" -t "$HOME" -n "$module" 2>/tmp/stow-err; then
    echo "  CONFLICT $module — resolve then re-run:"
    cat /tmp/stow-err
    echo "  Hint: move existing file aside, or run 'stow --restow $module' if previously linked."
    exit 1
  fi
  stow -d "$DOTFILES_DIR" -t "$HOME" --restow "$module"
  echo "  linked $module"
done

echo "==> Done. Open new shell or 'exec \$SHELL'."
