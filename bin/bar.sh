#!/usr/bin/env bash

killall -q lemonbar

. config.sh
PANEL_MON="eDP1"

admiral | lemonbar -f'DejaVu Sans Mono':size=10 -fFontAwesome:size=12 -F ${config_foreground//\'} -B"#00000000" -gx25 $PANEL_MON | zsh

