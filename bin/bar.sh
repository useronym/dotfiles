#!/usr/bin/env bash

killall -q lemonbar

. config.sh
PANEL_MON="eDP1"

admiral | lemonbar -f'mononoki':size=11 -fFontAwesome:size=12 -F ${config_foreground//\'} -B"#a0"${config_black:2:-1} -gx25 $PANEL_MON | zsh

