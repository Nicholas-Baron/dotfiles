#!/bin/sh

battery=$(sudo tlp-stat -b | tac | grep -m 1 "Charge" | tr -d -c "[:digit:],.")
charging=$(sudo tlp-stat -b | tac | grep -m 1 "status" | grep -Eio "(discharging|charging)" | tr '[A-Z]' '[a-z]')

if [ $battery = "" ] || [ $charging = "" ]; then
    echo "On desktop?"
else
    echo "$charging $battery %"
fi
