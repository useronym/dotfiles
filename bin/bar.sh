#!/usr/bin/env bash

killall -q lemonbar

source "colors.sh"
PANEL_MON="eDP-1"

admiral | lemonbar -f'Misc Ohsnap':size=14 -f'Siji':size=13 -o -1 -F"$c_fg" -B"$c_bg" -U"$c_fg" -gx20 $PANEL_MON | zsh

