#!/usr/bin/env bash

calc() { awk "BEGIN{printf \"%2.0f\", $*}"; }


WALLPS=(~/.wallpapers/*)
SND_MON="$HOME/.wallpapers/ws_Minimal_Gray_to_White_Gradient_1920x1080.jpg"

rnd=$(( $(date +%s) % ${#WALLPS[@]} ))
killall -q panel.sh

data=$(convert ${WALLPS[rnd]} -colorspace gray -verbose info:)
mean=$(echo "$data" | sed -n '/^.*[Mm]ean:.*[(]\([0-9.]*\).*$/{ s//\1/; p; q; }')
if [ $(calc "$mean * 100") -ge 50 ]; then
    panel_fg="#FF000000"
else
    panel_fg="#FFFFFFFF"
fi


feh --bg-fill ${WALLPS[rnd]} --bg-fill $SND_MON
panel.sh | lemonbar -fMonospace:size=10 -fFontAwesome:size=12 -F$panel_fg -B"#00000000" -g1600x25 eDP1 | zsh &
