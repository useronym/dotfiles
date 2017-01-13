#!/usr/bin/env bash

. config.sh

STATUS=$(amixer get Master | grep 'Left: Playback' | grep -o '\[on]')
VOLUME=$(amixer get Master | grep 'Left: Playback' | grep -o '...%' | sed 's/\[//' | sed 's/%//' | sed 's/ //')
echo -ne "%{B${config_primary:1:-1}} "
if [ "$STATUS" = "[on]" ] && [ $VOLUME -gt 0 ]; then
    echo -ne "%{T2}\ue050%{T1}%{B-} $VOLUME% "
else
    echo -ne '%{T2}\ue04f%{T1}%{B-} off '
fi
