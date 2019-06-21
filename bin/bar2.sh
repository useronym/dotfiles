#!/usr/bin/env bash

sleep 1 # so that bar.sh doesn't kill us

source "colors.sh"

PANEL_MON=$(get_mon.sh 2)
if [[ "$PANEL_MON" == "" ]]; then
    exit 0
fi

admiral -c ~/.config/admiral.d/secondary.toml | lemonbar -b -f'Misc Ohsnap':size=14 -f'Siji':size=13  -F$c_fg -B$c_bg -U$c_fg -gx25 $PANEL_MON | zsh

