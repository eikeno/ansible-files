#!/bin/sh
# Install yay AUR package manager. To be run as regular user.

mkdir -p ~/$HOME/arch
pushd ~/$HOME/arch || exit
git clone https://aur.archlinux.org/yay.git || exit
pushd yay || exit
makepkg -si