#!/usr/bin/env bash

#DATA=$(curl 'http://api.openweathermap.org/data/2.5/weather?id=723846&appid=1b3106852d5d55db8af8bdc5ccd2313f')
DATA=$(curl 'http://api.openweathermap.org/data/2.5/weather?id=3078610&appid=1b3106852d5d55db8af8bdc5ccd2313f')
if [ "$?" -ne "0" ]; then return -1; fi

WEATHER=$(echo $DATA | jq -r '.weather[0].main')
TEMP=$(echo $DATA | jq -r '.main.temp')
TEMP=${TEMP%.*}
NIGHT=$(echo $WEATHER | cut -d " " -f1)
shopt -s nocasematch
#case $WEATHER in
#    *fog* | *mist*) echo -ne '%{T2}\uf070%{T1}';;
#    *storm*) echo -ne '%{T2}\uf0e7%{T1}';;
#    *rain* | *drizzle*) echo -ne '%{T2}\uf043%{T1}';;
#    *cloud*) echo -ne '%{T2}\uf0c2%{T1}';;
#    *snow*) echo -ne '%{T2}\uf069%{T1}';;
#    *sun* | *clear*)
#        if [ "$NIGHT" == "night" ]; then
#            echo -ne '%{T2}\uf186%{T1}'
#        else
#            echo -ne '%{T2}\uf185%{T1}'
#        fi;;
#esac
echo -n " $WEATHER, $(($TEMP-273))°C "
