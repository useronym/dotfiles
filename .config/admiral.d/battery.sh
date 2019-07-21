#!/usr/bin/env bash

BAT_BIAS=4 # My battery often decides to stop charging at what is reported as 97-99%

source "colors.sh"

BAT=$(cat /sys/class/power_supply/BAT0/capacity)

STATUS=$(cat /sys/class/power_supply/BAT0/status)
if [ "$STATUS" = "Charging" ]; then
    echo -ne "%{F$c_blue}"
elif [ "$BAT" -le "9" ]; then
    echo -ne "%{F$c_red}"
else
    BAT=$(((BAT + BAT_BIAS) >= 100 ? 100 : BAT))
    echo -ne "%{F$c_fg}"
fi
echo -ne '%{R} '
case $BAT in
    9* | 100) echo -ne '%{T2}\ue24b%{T1}';;
    8*)       echo -ne '%{T2}\ue24a%{T1}';;
    7*)       echo -ne '%{T2}\ue249%{T1}';;
    6*)       echo -ne '%{T2}\ue248%{T1}';;
    5*)       echo -ne '%{T2}\ue247%{T1}';;
    4*)       echo -ne '%{T2}\ue246%{T1}';;
    3*)       echo -ne '%{T2}\ue245%{T1}';;
    2*)       echo -ne '%{T2}\ue244%{T1}';;
    1*)       echo -ne '%{T2}\ue243%{T1}';;
    *)        echo -ne '%{T2}\ue242%{T1}';;
esac
echo -ne '%{R}%{F-}'
echo -n " $BAT% "
