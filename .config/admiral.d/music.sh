#!/usr/bin/env bash

APP=spotify

if [ "$(pidof $APP)" ]; then
    artist=$(playerctl metadata artist)
    title=$(playerctl metadata title)
    album=$(playerctl metadata album)
   
    shopt -s nocasematch
    #echo -ne '%{R} '
    case $(playerctl status) in
        *stopped*) echo -ne '%{T2}\ue057%{T1}';;
        *playing*) echo -ne '%{T2}\ue058%{T1}';;
        *paused*) echo -ne '%{T2}\ue059%{T1}';;
    esac
    #echo -ne '%{R}'

    printf " %s - %s (%s) " "$artist" "$title" "$album"
fi
