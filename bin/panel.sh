#!/usr/bin/bash

PAD="  "
BAT_BIAS=2 # My battery often decides to stop charging at what is reported as 98%
IW="wlp2s0"

Clock() {
    DATE=$(date "+%a %b %d, %H:%M")
    echo -n "$DATE"
}

Battery() {
    BAT=$(cat /sys/class/power_supply/BAT0/capacity)
    BAT=$(((BAT + BAT_BIAS) >= 100 ? 100 : BAT))
    case $BAT in
        8* | 9* | 100)  echo -ne '%{T2}\uf240%{T1}';;
        6* | 7*)        echo -ne '%{T2}\uf241%{T1}';;
        4* | 5*)        echo -ne '%{T2}\uf242%{T1}';;
        1* | 2* | 3*)   echo -ne '%{T2}\uf243%{T1}';;
        *)              echo -ne '%{T2}\uf244%{T1}';;
    esac
    echo -n $BAT%
}

Wifi() {
    WIFI_SSID=$(iw $IW link | grep 'SSID' | sed 's/SSID: //' | sed 's/\t//')
    #WIFI_SIGNAL=$(iw $IW link | grep 'signal' | sed 's/signal: //' | sed 's/ dBm//' | sed 's/\t//')
    echo -ne '%{A:nm-connection-editor:}%{T2}\uf1eb%{T1}' $WIFI_SSID '%{A}'
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
    URL='http://www.accuweather.com/en/cz/brno/123291/weather-forecast/123291'
    WEATHER=$(wget -q -O- "$URL" | awk -F\' '/acm_RecentLocationsCarousel\.push/{print  $14", "$12"°" }'| head -1)
    case $WEATHER in
        Foggy*) echo -ne '%{T2}\uf070%{T1}';;
        Sunny* | Clear*) echo -ne '%{T2}\uf185%{T1}';;
        *) echo -ne '%{T2}\uf0e7%{T1}';;
    esac
    echo -n " $WEATHER"
}


c=0
while true; do
    if [ $((c % 10)) -eq 0 ]; then clock="$(Clock)"; fi
    if [ $((c % 15)) -eq 0 ]; then wifi="$(Wifi)"; fi
    if [ $((c % 60)) -eq 0 ]; then battery="$(Battery)"; fi
    if [ $((c % 900)) -eq 0 ]; then weather="$(Weather)"; fi
    echo -n "%{l}"$PAD" $clock "$PAD" $weather %{r}$(Sound) "$PAD" $wifi "$PAD" $battery "$PAD""
    echo -e "%{A2:poweroff:}%{A3:reboot:} "$PAD" %{T2}\uf011%{T1} "$PAD" %{A}%{A}"
    c=$((c+1));
    sleep 1;
done
