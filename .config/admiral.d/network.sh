#!/usr/bin/env bash

WIFI="wlp2s0"
ETH="enp0s20u1"
ETH2="enp0s20u2"
INTERFACE=""

source "colors.sh"

ETHERNET=$(ip link | grep $ETH | grep -o "state UP")
TETHER=$(ip link | grep $ETH2 | grep -o "state UNKNOWN")
WIFI_SSID=$(iw $WIFI link | grep 'SSID' | sed 's/SSID: //' | sed 's/\t//')
if [ "$ETHERNET" = "state UP" ]; then
    INTERFACE=$ETH
    echo -ne '%{A:termite -e nmtui:}%{T2}%{R} \ue26d%{R}%{T1}%{B-}' ethernet '%{A}'
elif [ "$TETHER" = "state UNKNOWN" ]; then
    INTERFACE=$ETH2
    echo -ne '%{A:termite -e nmtui:}%{T2}%{R} \ue26d%{R}%{T1}%{B-}' tethered '%{A}'
elif [ "$WIFI_SSID" ]; then
    INTERFACE=$WIFI
    echo -ne '%{A:termite -e nmtui:}%{T2}%{R} \ue1af%{R}%{T1}%{B-}' $WIFI_SSID '%{A}'
else
    echo -ne '%{A:termite -e nmtui:}%{T2}%{R} \ue26d%{R}%{T1}%{B-}' no network '%{A}'
    exit 0
fi

# Get bandwidths usage in the last second
band=$(get_bandwidth.sh $INTERFACE)
down=$(echo $band | cut -d ' ' -f 1)
up=$(echo $band | cut -d ' ' -f 2)
down_mb=$(bc <<< "scale=2; $down / 1000000")
up_mb=$(bc <<< "scale=2; $up / 1000000")

# Get total bandwidth usage since start of session.
total=$(cat /proc/net/dev | grep $INTERFACE | sed -r 's/[ \t]+/ /g' | cut -d ' ' -f 2,10)
down_total=$(echo $total | cut -d ' ' -f 1)
up_total=$(echo $total | cut -d ' ' -f 2)
down_total_mb=$(($down_total / 1000000))
up_total_mb=$(($up_total / 1000000))

echo -ne "%{T2}%{R} \ue12c%{R}%{T1} "$(printf "%.2f" $down_mb)/s" | $down_total_mb"'MB '
echo -ne "%{T2}%{R} \ue12b%{R}%{T1} "$(printf "%.2f" $up_mb)/s" | $up_total_mb"'MB '
