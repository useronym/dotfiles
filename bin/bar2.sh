#!/usr/bin/env bash

sleep 1 # so that bar.sh doesn't kill us

source "colors.sh"

PANEL_MON=$(get_snd_mon.sh)
if [[ "$PANEL_MON" == "" ]]; then
    exit 0
fi

admiral -c ~/.config/admiral.d/secondary.toml | lemonbar -b -f'Misc Ohsnap':size=13 -F$c_fg -B$c_bg -gx25 $PANEL_MON | zsh

