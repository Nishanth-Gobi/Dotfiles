#!/usr/bin/env bash


# --------------------- #
# SYSTEM SETUP SCRIPT
# Author: Nishanth Gobi
# --------------------- #


# ------------ #
# System update
# ------------ #
sudo pacman -Syu
# ------------ #

# ------------ #
# Timeshift
# ------------ #
sudo pacman -S timeshift
sudo timeshift --create --comments "Base System"
sudo timeshift --list
# ------------ #

# ------------ #
# LTS Kernal
# ------------ #

lts_kernal_list_length=$(pacman -Q | grep linux-lts | wc -l)

if [ $lts_kernal_list_length -ge 1 ] 
then
    echo "LTS Kernal already found"
else
    sudo pacman -S linux-lts linux-lts-headers
    sudo grub-mkconfig -o /boot/grub/grub.cfg
    echo "Finished LTS Kernal setup"
fi
echo Current kernal: $(uname -r)

# ------------ #

# ------------ #
# Enable Snap support
# ------------ #

cd

mkdir System
cd System
git clone https://aur.archlinux.org/snapd.git
cd snapd/

makepkg -si
sudo systemctl enable --now snapd.socket

echo "Waiting..."
echo "U: Check out: https://snapcraft.io/docs/installing-snap-on-arch-linux"
sleep 15

sudo ln -s /var/lib/snapd/snap /snap

echo "U: Logout & login?" 
# Write the line nubmer to a file and run commands 
# starting from that number upon script re-execution 

sudo snap install hello-world
hello-world

