#!/bin/bash

# Check root
if [ "$EUID" == 0 ]
  then echo "This script must be run as a standard user, otherwise configuration files will be installed in /root."
  exit
fi

# Install dependencies
sudo pacman -S exa alacritty bspwm sxhkd polybar rofi firefox vim ttf-iosevka-nerd feh picom pulsemixer brightnessctl bc feh imagemagick xorg-xdpyinfo xorg-xrandr --needed

# Install AUR packages
if sudo pacman -Q | grep -q i3lock-color; then
	echo "i3lock-color already installed, skipping."
else
	sudo pacman -S base-devel --needed
	mkdir -p ~/misc/clone
	cd ~/misc/clone
	git clone https://aur.archlinux.org/i3lock-color.git
	cd i3lock-color
	makepkg -si
	cd ~/misc
fi

if sudo pacman -Q | grep -q betterlockscreen; then
	echo "Betterlockscreen already installed, skipping."
else
	mkdir -p ~/misc/clone
	cd ~/misc/clone
	git clone https://aur.archlinux.org/betterlockscreen.git
	cd betterlockscreen
	makepkg -si
	cd ~/misc
	rm clone/ -rf
fi

# Install dotfiles
mkdir ~/.config 2>/dev/null
cp -r bspwm/ alacritty/ rofi/ fastfetch/ sxhkd/ ~/.config/
cp -r Pictures ~/
sudo cp -r polybar/ /etc/
sudo cp -r picom/ /etc/xdg/

# Finish
echo ""
echo "Done. Make sure to run \`betterlockscreen -u ~/Pictures/water.png\` after starting BSPWM."
echo "Be advised, no display manager was installed by the script. If you do not have one in mind, I recommend ly from the AUR."
