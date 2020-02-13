#!/bin/sh

if [ ! -d polybar ]; then
    git clone https://github.com/polybar/polybar.git
    cd polybar || exit
else
    cd polybar || exit
    git pull
fi

./build.sh -j -n -p -A
