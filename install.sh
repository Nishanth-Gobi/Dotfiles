#!bin/bash

# 1. Install Homebrew
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# 2. Sync packages
echo "Installing packages and casks from Brewfile..."
brew bundle --file=~/Dotfiles/Brewfile

# 3. Run Stow
modules=(home zsh git kitty nvim aerospace assets)

echo "Stowing configs..."
for module in "${modules[@]}"; do
  stow "$module"
done

echo "Setup complete and you are ready to go!"
