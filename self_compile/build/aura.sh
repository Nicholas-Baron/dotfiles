#!/bin/sh

git clone https://aur.archlinux.org/aura-bin.git

cd aura-bin || exit

makepkg -si
