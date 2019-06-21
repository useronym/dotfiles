#!/usr/bin/env bash

offset=$1
offset=${offset:=1}
mons=(eDP1 HDMI2 DP1)

for m in ${mons[@]}; do
    res=$(xrandr -q | grep -o "^$m connected [^(]")
    if [[ "$res" == *"connected"* ]]; then
        offset=$((offset-1))
        if [ $offset -eq 0 ]; then
            echo $m
            exit 0
        fi
    fi
done

exit 1
