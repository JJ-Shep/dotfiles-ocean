#!/bin/bash

# Check root
if [ "$EUID" == 0 ]
  then echo "This script must be run as a standard user, otherwise configuration files will be installed in /root."
  exit
fi

sudo pacman -S exa alacritty bspwm sxhkd polybar rofi firefox vim ttf-iosevka-nerd feh picom pulsemixer brightnessctl bc feh i3lock-color imagemagick xorg-xdpyinfo xorg-xrandr --needed

# Install betterlockscreen from AUR
echo "Beginning installation of required programs."
if sudo pacman -Q | grep -q betterlockscreen; then
	echo "Betterlockscreen already installed, skipping."
else
	sudo pacman -S base-devel --needed
	mkdir -p ~/misc/clone
	cd ~/misc/clone
	git clone https://aur.archlinux.org/betterlockscreen.git
	cd betterlockscreen
	makepkg -si
	cd ~/misc/clone
	rm betterlockscreen/ -rf
fi

# Install dotfiles
cp -r bspwm/ alacritty/ rofi/ fastfetch/ ~/.config/
cp -r Pictures ~/
sudo cp -r polybar/ /etc/
sudo cp -r picom/ /etc/xdg/

# Finish
echo "Applying finishing touches"
betterlockscreen -u ~/Pictures/water.png
