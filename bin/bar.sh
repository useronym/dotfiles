#!/usr/bin/env bash

killall -q lemonbar

. config.sh
PANEL_MON="eDP1"

admiral | lemonbar -f'Misc Ohsnap':size=13 -f'Wuncon Siji':size=13 -F${config_foreground:1:-1} -B'#cc'${config_background:2:-1} -gx25 $PANEL_MON | zsh

