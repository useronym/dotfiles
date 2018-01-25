#!/usr/bin/env bash

source "colors.sh"

STATUS=$(amixer get Master | grep 'Left: Playback' | grep -o '\[on]')
VOLUME=$(amixer get Master | grep 'Left: Playback' | grep -o '...%' | sed 's/\[//' | sed 's/%//' | sed 's/ //')
if [ "$STATUS" = "[on]" ] && [ $VOLUME -gt 0 ]; then
    echo -ne "%{T2}%{R} \ue050%{R}%{T1}%{B-} $VOLUME% "
else
    echo -ne '%{T2}%{R} \ue04f%{R}%{T1}%{B-} off '
fi
