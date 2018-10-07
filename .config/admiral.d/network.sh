#!/usr/bin/env bash

WIFI="wlp2s0"
ETH="enp0s20u1"

source "colors.sh"

ETHERNET=$(ip link | grep $ETH | grep -o "state UP")
WIFI_SSID=$(iw $WIFI link | grep 'SSID' | sed 's/SSID: //' | sed 's/\t//')
if [ "$ETHERNET" = "state UP" ]; then
    echo -ne '%{A:termite -e nmtui:}%{T2}%{R} \ue26d%{R}%{T1}%{B-}' ethernet '%{A}'
else
    echo -ne '%{A:termite -e nmtui:}%{T2}%{R} \ue1af%{R}%{T1}%{B-}' $WIFI_SSID '%{A}'
fi

band=$(get_bandwidth.sh)
down=$(echo $band | cut -d ' ' -f 1)
up=$(echo $band | cut -d ' ' -f 2)
down_mb=$(bc <<< "scale=2; $down / 1000000")
up_mb=$(bc <<< "scale=2; $up / 1000000")

echo -ne "%{T2} \ue12c%{T1}"$(printf "%.2f" $down_mb)/s
echo -ne "%{T2} \ue12b%{T1}"$(printf "%.2f" $up_mb)/s' '
