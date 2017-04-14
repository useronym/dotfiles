#!/usr/bin/env bash

WIFI="wlp2s0"
ETH="enp0s20u1"

source "colors.sh"

ETHERNET=$(ip link | grep $ETH | grep -o "state UP")
WIFI_SSID=$(iw $WIFI link | grep 'SSID' | sed 's/SSID: //' | sed 's/\t//')
echo -ne "%{B$c_bg} "
if [ "$ETHERNET" = "state UP" ]; then
    echo -ne '%{A:termite -e nmtui:}%{T2}\ue26d%{T1}%{B-}' ethernet '%{A}'
else
    echo -ne '%{A:termite -e nmtui:}%{T2}\ue1af%{T1}%{B-}' $WIFI_SSID '%{A}'
fi
