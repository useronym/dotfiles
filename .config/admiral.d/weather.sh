#!/usr/bin/env bash

source "colors.sh"

DATA=$(curl 'http://api.openweathermap.org/data/2.5/weather?id=723846&appid=1b3106852d5d55db8af8bdc5ccd2313f')
#DATA=$(curl 'http://api.openweathermap.org/data/2.5/weather?id=3078610&appid=1b3106852d5d55db8af8bdc5ccd2313f')
if [ "$?" -ne "0" ]; then exit -1; fi


WEATHER=$(echo $DATA | jq -r '.weather[0].main')
TEMP=$(echo $DATA | jq -r '.main.temp')
TEMP=${TEMP%.*}

SUNRISE=$(echo $DATA| jq -r '.sys.sunrise')
SUNSET=$(echo $DATA| jq -r '.sys.sunset')
NOW=$(date '+%s')
if [ "$NOW" -le "$SUNRISE" ] || [ "$NOW" -ge "$SUNSET" ]; then
    NIGHT="night"
fi

echo -ne '%{R} '
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
echo -ne '%{R}'
echo -n " $WEATHER, $(($TEMP-273))°C "
