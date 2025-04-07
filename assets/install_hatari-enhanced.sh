#!/usr/bin/env bash

tempdir=$(mktemp -d -t hatari-XXXXXXXX)
pushd $tempdir || exit

git clone https://aur.archlinux.org/hatari-enhanced-git.git

pushd hatari-enhanced-git || exit
sed -i 's,git://git.tuxfamily.org/gitroot/hatari/hatari.git,git+https://framagit.org/hatari/hatari.git,g' PKGBUILD
makepkg -si --noconfirm
