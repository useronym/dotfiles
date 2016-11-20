#!/usr/bin/env bash

WIFI="wlp2s0"
ETH="enp0s20u1"

ETHERNET=$(ip link | grep $ETH | grep -o "state UP")
WIFI_SSID=$(iw $WIFI link | grep 'SSID' | sed 's/SSID: //' | sed 's/\t//')
if [ "$ETHERNET" = "state UP" ]; then
    echo -ne '%{A:termite -e nmtui:}%{T2}\uf0ac%{T1}' ethernet'%{A}'
else
    echo -ne '%{A:termite -e nmtui:}%{T2}\uf1eb%{T1}' $WIFI_SSID'%{A}'
fi
