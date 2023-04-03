#!/usr/bin/env bash


# --------------------- #
# APP INSTALL SCRIPT
# Author: Nishanth Gobi
# --------------------- #


# ------------ #
# Fish Shell
# ------------ #
sudo pacman -S fish
fish --version
chsh -s /bin/fish

# ------------ #
# Neofetch
# ------------ #
sudo pacman -S neofetch
echo  "neofetch"  >> .config/fish/config.fish

# ------------ #
# VS Code
# ------------ #
yay -S visual-studio-code-bin

# ------------ #
# Brave
# ------------ #
yay -S brave-bin

# ------------ #
# Obsidian
# ------------ #
echo "U: Download the latest obsidian AppImage"
read -p "Press any key to continue..." -n1 -s
mv Downloads/Obsidian-1.1.9.AppImage /bin/

echo "Creating a desktop entry... \n"

cd /usr/share/applications/
echo "[Desktop Entry]
Name=Obsidian
Exec=/bin/Obsidian-1.1.9.AppImage
Terminal=false
Type=Application
Icon=md.obsidian.Obsidian
Comment=Obsidian
MimeType=x-scheme-handler/obsidian;
Categories=Office;" >> obsidian.desktop

