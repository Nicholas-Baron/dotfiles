#!/bin/bash

for folder in */; do
    if ! [[ $folder =~ build ]]; then
        echo "Removing $folder..."
        rm -rI "$folder"
    fi
done
