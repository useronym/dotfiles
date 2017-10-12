#!/usr/bin/env bash

killall -q lemonbar

source "colors.sh"
PANEL_MON="eDP1"

admiral | lemonbar -f'Misc Ohsnap':size=14 -f'Wuncon Siji':size=13 -F"$c_fg" -B"$c_bg" -U"$c_fg" -gx20 $PANEL_MON | zsh

