#!/usr/bin/env bash

calc() { awk "BEGIN{printf \"%2.0f\", $*}"; }

WALLPS=(~/Pictures/*.{jpg,png})
SND_MON="$HOME/Pictures/Dark-Black-Background.jpg"

rnd=$(( $(date +%s) % ${#WALLPS[@]} ))
wallp=${WALLPS[rnd]}
wallp_file="$wallp.color"

mkdir -p $DATA_DIR
if [ -f $wallp_file ]; then
    read -r line < $wallp_file
    $panel_fg = "$line"
else
    data=$(convert $wallp -crop x50 -colorspace gray -verbose info:)
    mean=$(echo "$data" | sed -n '/^.*[Mm]ean:.*[(]\([0-9.]*\).*$/{ s//\1/; p; q; }')
    if [ $(calc "$mean * 100") -ge 66 ]; then
        panel_fg="#FF000000"
    else
        panel_fg="#FFFFFFFF"
    fi
    echo $panel_fg > $wallp_file
fi


killall -q panel.sh
$XDG_CONFIG_HOME/bspwm/bspwmrc
feh --bg-fill ${WALLPS[rnd]} --bg-fill $SND_MON
panel.sh | lemonbar -fMonospace:size=10 -fFontAwesome:size=12 -F$panel_fg -B"#00000000" -g1600x25 eDP1 | zsh &
