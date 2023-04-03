#!/usr/bin/env bash


# --------------------- #
# CONFIGS SCRIPT
# Author: Nishanth Gobi
# --------------------- #


# ------------ #
# Git
# ------------ #
echo ""
git config --global user.email "nish.professional@gmail.com"
git config --global user.name "Nishanth Gobi"

echo "Generating SSH key for GitHub..."

ssh-keygen -t ed25519 -C "nish.professional@gmail.com"
bash -c 'eval "$(ssh-agent -s)"'
bash -c 'ssh-add ~/.ssh/id_ed25519'
cat ~/.ssh/id_ed25519.pub

echo "U: Copy the key and add it to your GitHub SSH keys"
sleep 2
read -p "Press any key to continue... " -n1 -s


# ------------ #
# Openbox decor removal
# ------------ #

echo "U: To remove decorations in case of openbox"
echo "U: Run `In .config/openbox/rc.xml set <decor>no<decor>`"

# ------------ #
# Clone my digital garden
# ------------ #
echo "Cloning my digital garden..."
cd && cd Documents/
git clone git@github.com:Nishanth-Gobi/Nishanth-Gobi.git
cd
