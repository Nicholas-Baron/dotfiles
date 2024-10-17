#!/bin/sh
git clone https://aur.archlinux.org/aura.git

cd aura || exit

makepkg -id
