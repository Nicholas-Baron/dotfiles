#!/bin/sh

git clone https://github.com/polybar/polybar.git
cd polybar || exit
./build.sh -j -n -p -A
