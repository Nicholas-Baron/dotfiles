#!/bin/sh

if [ ! -d polybar ]; then
    git clone https://github.com/polybar/polybar.git
    cd polybar || exit
else
    cd polybar || exit
    git pull
fi

if [ ! -d build ]; then
    mkdir build
    cd build || exit
    cmake -GNinja -DBUILD_DOC_HTML=FALSE -DBUILD_CONFIG=FALSE -DBUILD_SHELL=FALSE ..
fi

sudo ninja install
