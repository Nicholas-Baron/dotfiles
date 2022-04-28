#!/bin/sh

if [ $(hostname) = "archbox" ]; then
    echo "On desktop"
    exit
fi

battery=$(sudo tlp-stat -b | tac | grep -m 1 "Charge" | tr -d -c "[:digit:],.")
charging=$(sudo tlp-stat -b | tac | grep -m 1 "status" | grep -Eio "(discharging|charging)" | tr '[A-Z]' '[a-z]')

if [ $battery = "" ] || [ $charging = "" ]; then
    echo "Is TLP installed?"
else
    echo "$charging $battery %"
fi
