#!/usr/bin/env bash

STATUS=$(amixer get Master | grep 'Left: Playback' | grep -o '\[on]')
VOLUME=$(amixer get Master | grep 'Left: Playback' | grep -o '...%' | sed 's/\[//' | sed 's/%//' | sed 's/ //')
if [ "$STATUS" = "[on]" ] && [ $VOLUME -gt 0 ]; then
    echo -ne '%{T2}\uf028%{T1}' $VOLUME%
else
    echo -ne '%{T2}\uf026%{T1}' "off"
fi
