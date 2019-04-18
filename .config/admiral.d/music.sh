#!/usr/bin/env bash

APP=spotify

if [ "$(pidof $APP)" ]; then
    artist=$(playerctl metadata artist)
    title=$(playerctl metadata title)
    album=$(playerctl metadata album)
    printf "%s - %s (%s) " "$artist" "$title" "$album"
fi
