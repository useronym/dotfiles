#!/usr/bin/env bash

. config.sh

#DATA=$(curl 'http://api.openweathermap.org/data/2.5/weather?id=723846&appid=1b3106852d5d55db8af8bdc5ccd2313f')
DATA=$(curl 'http://api.openweathermap.org/data/2.5/weather?id=3078610&appid=1b3106852d5d55db8af8bdc5ccd2313f')
if [ "$?" -ne "0" ]; then return -1; fi

echo -ne "%{B${config_primary:1:-1}} "

WEATHER=$(echo $DATA | jq -r '.weather[0].main')
TEMP=$(echo $DATA | jq -r '.main.temp')
TEMP=${TEMP%.*}
NIGHT=$(echo $WEATHER | cut -d " " -f1)
shopt -s nocasematch
case $WEATHER in
    *fog* | *mist*) echo -ne '%{T2}\ue22d%{T1}';;
    *storm*) echo -ne '%{T2}\ue22c%{T1}';;
    *rain* | *drizzle*) echo -ne '%{T2}\ue22f%{T1}';;
    *snow*) echo -ne '%{T2}\ue22e%{T1}';;
    *cloud*)
        if [ "$NIGHT" == "night" ]; then
            echo -ne '%{T2}\ue232%{T1}'
        else
            echo -ne '%{T2}\ue22b%{T1}'
        fi;;
    *sun* | *clear*)
        if [ "$NIGHT" == "night" ]; then
            echo -ne '%{T2}\ue233%{T1}'
        else
            echo -ne '%{T2}\ue234%{T1}'
        fi;;
esac
echo -ne '%{B-}'
echo -n " $WEATHER, $(($TEMP-273))°C "
