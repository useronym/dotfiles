#!/usr/bin/env bash

sleep 1 # so that bar.sh doesn't kill us

source "colors.sh"

admiral -c ~/.config/admiral.d/secondary.toml | lemonbar -f'Misc Ohsnap':size=14 -f'Siji':size=13  -F$c_fg -B$c_bg -U$c_fg -gx20 default | zsh

