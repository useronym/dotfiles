#!/usr/bin/env bash

sleep 1 # so that bar.sh doesn't kill us

. config.sh

PANEL_MON=$(get_snd_mon.sh)
if [[ "$PANEL_MON" == "" ]]; then
    exit 0
fi

admiral -c ~/.config/admiral.d/secondary.toml | lemonbar -b -f'DejaVu Sans Mono':size=10 -fFontAwesome:size=12 -F ${config_foreground//\'} -B"#00000000" -gx25 $PANEL_MON | zsh

