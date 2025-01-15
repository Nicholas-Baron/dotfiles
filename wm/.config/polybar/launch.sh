#!/bin/bash

killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if type "xrandr"; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar -r mybar 2> .config/polybar/log_$m &
    done
else
    polybar -r mybar 2> .config/polybar/log &
fi

