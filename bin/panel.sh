#!/usr/bin/bash

PAD="  "
BAT_BIAS=3 # My battery often decides to stop charging at what is reported as 97-99%
IW="wlp2s0"

Clock() {
    DATE=$(date "+%{T2}\uf017%{T1}  %a %B %-d  %H:%M")
    echo -ne "$DATE"
}

Battery() {
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
    echo -n " $BAT %"
}

Wifi() {
    WIFI_SSID=$(iw $IW link | grep 'SSID' | sed 's/SSID: //' | sed 's/\t//')
    #WIFI_SIGNAL=$(iw $IW link | grep 'signal' | sed 's/signal: //' | sed 's/ dBm//' | sed 's/\t//')
    echo -ne '%{A:termite -e nmtui:}%{T2}\uf1eb%{T1}' $WIFI_SSID'%{A}'
}

Sound() {
    STATUS=$(amixer get Master | grep 'Left: Playback' | grep -o '\[on]')
    VOLUME=$(amixer get Master | grep 'Left: Playback' | grep -o '...%' | sed 's/\[//' | sed 's/%//' | sed 's/ //')
    if [ "$STATUS" = "[on]" ] && [ $VOLUME -gt 0 ]; then
        echo -ne '%{T2}\uf028%{T1}' $VOLUME%
    else
        echo -ne '%{T2}\uf026%{T1}' "off"
    fi
}

Backlight() {
    STATUS=$(xbacklight | awk '{print int($1+0.5)}')
    echo -ne '%{T2}\uf185%{T1}' $STATUS%
}

Weather() {
    DATA=$(curl 'http://api.openweathermap.org/data/2.5/weather?id=3078610&appid=1b3106852d5d55db8af8bdc5ccd2313f')
    if [ "$?" -ne "0" ]; then return -1; fi

    WEATHER=$(echo $DATA | jq -r '.weather[0].main')
    TEMP=$(echo $DATA | jq -r '.main.temp')
    TEMP=${TEMP%.*}
    NIGHT=$(echo $WEATHER | cut -d " " -f1)
    shopt -s nocasematch
    case $WEATHER in
        *fog* | *mist*) echo -ne '%{T2}\uf070%{T1}';;
        *storm*) echo -ne '%{T2}\uf0e7%{T1}';;
        *rain* | *drizzle*) echo -ne '%{T2}\uf043%{T1}';;
        *cloud*) echo -ne '%{T2}\uf0c2%{T1}';;
        *snow*) echo -ne '%{T2}\uf069%{T1}';;
        *sun* | *clear*)
            if [ "$NIGHT" == "night" ]; then
                echo -ne '%{T2}\uf186%{T1}'
            else
                echo -ne '%{T2}\uf185%{T1}'
            fi;;
    esac
    echo -n " $WEATHER, $(($TEMP-273))°C"
}

Mail() {
    MAIL=$(mailcheck -c)
    if [ "$MAIL" != "" ]; then
        MAILS=$(echo $MAIL | cut -d " " -f 3)
        echo -ne "%{A:termite -e sup:}%{T2}\uf0e0%{T1} $MAILS new%{A}"
    fi
}


c=0
while true; do
    if [ $((c % 10)) -eq 0 ]; then clock="$(Clock)"; fi
    if [ $((c % 15)) -eq 0 ]; then wifi="$(Wifi)"; fi
    if [ $((c % 60)) -eq 0 ]; then battery="$(Battery)"; fi
    if [ $((c % 60)) -eq 0 ]; then mail="$(Mail)"; fi
    if [ $((c % 900)) -eq 10 ]; then weather="$(Weather)"; fi
    echo -n "%{l}"$PAD" $clock "$PAD" $weather %{r}$mail "$PAD" $wifi "$PAD" $(Sound) "$PAD" $battery "$PAD""
    echo -e "%{A2:poweroff:}%{A3:reboot:} "$PAD" %{T2}\uf011%{T1} "$PAD" %{A}%{A}"
    c=$((c+1));
    sleep 1;
done
