#!/usr/bin/env bash

SND_MON="ws_Minimal_Gray_to_White_Gradient_1920x1080.jpg"
WALLPS=(
    "02229_amomentofsilence_1920x1080.jpg"
    "23284779026_4d37b60bd3_o.jpg"
    "photo-1433785124354-92116416b870.jpg"
    "jtLyKzv.jpg"
    "yFPJpuj.jpg"

    "1kqje2A.jpg"
    "23297943575_60fb6af0dc_k.jpg"
    "CqwQVj1.jpg"
    "yuvvxPS.jpg")
PANEL_FG=(
    "#FF000000"
    "#FF000000"
    "#FF000000"
    "#FF000000"
    "#FF000000"

    "#FFFFFFFF"
    "#FFFFFFFF"
    "#FFFFFFFF"
    "#FFFFFFFF")
PANEL_BG=(
    "#00000000"
    "#00000000"
    "#00000000"
    "#00000000"
    "#00000000"

    "#00000000"
    "#00000000"
    "#00000000"
    "#00000000")


rnd=$(( $(date +%s) % ${#WALLPS[@]} ))

killall -q panel.sh
feh --bg-fill "$HOME/.wallpapers/${WALLPS[rnd]}" --bg-fill "$HOME/.wallpapers/$SND_MON"
panel.sh | lemonbar -fMonospace:size=10 -fFontAwesome:size=12 -F${PANEL_FG[rnd]} -B${PANEL_BG[rnd]} -g1600x25 eDP1 | zsh &
