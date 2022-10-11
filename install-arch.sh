#!/bin/bash

# Check root
if [ "$EUID" -ne 0 ]
  then echo "This script must be run with sudo to install programs and move files to directories in /etc/"
  exit
fi

# Install betterlockscreen from AUR
echo "Beginning installation of required programs."
if pacman -Q | grep -q betterlockscreen; then
	echo "Betterlockscreen already installed, skipping."
else
	pacman -S base-devel --needed
	mkdir -p ~/misc/clone
	cd ~/misc/clone
	git clone https://aur.archlinux.org/betterlockscreen.git
	cd betterlockscreen
	makepkg -si
	cd ~/misc/clone
	rm betterlockscreen/ -rf
fi

# Install packages
pacman -S exa alacritty bspwm sxhkd polybar rofi firefox vim ttf-iosevka-nerd feh picom pulsemixer brightnessctl --needed

# Install dotfiles
cp -r bspwm/ alacritty/ rofi/ fastfetch/ ~/.config/
cp -r Pictures ~/
sudo cp -r polybar/ /etc/
sudo cp -r picom/ /etc/xdg/

# Finish
echo "Applying finishing touches"
betterlockscreen -u ~/Pictures/water.png
