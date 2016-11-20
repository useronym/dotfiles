#!/usr/bin/env bash

BAT_BIAS=3 # My battery often decides to stop charging at what is reported as 97-99%

BAT=$(cat /sys/class/power_supply/BAT0/capacity)
BAT=$(((BAT + BAT_BIAS) >= 100 ? 100 : BAT))
case $BAT in
    1|2|3|4|5|6|7|8|9)            echo -ne '%{T2}%{F#FFFF0000}\uf244%{F-}%{T1}';;
    8* | 9* | 100)  echo -ne '%{T2}\uf240%{T1}';;
    6* | 7*)        echo -ne '%{T2}\uf241%{T1}';;
    4* | 5*)        echo -ne '%{T2}\uf242%{T1}';;
    1* | 2* | 3*)   echo -ne '%{T2}\uf243%{T1}';;
esac
STATUS=$(cat /sys/class/power_supply/BAT0/status)
if [ "$STATUS" = "Charging" ]; then
    echo -ne ' %{T2}%{F#FF2C75FF}\uf0e7%{F-}%{T1}'
fi
echo -n " $BAT%"
