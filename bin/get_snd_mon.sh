#!/usr/bin/env bash

mons=(HDMI-2 DP-1)

for m in ${mons[@]}; do
    res=$(xrandr -q | grep -o "^$m connected")
    if [ "$res" = "$m connected" ]; then
        echo $m
        exit 0
    fi
done

exit 1
