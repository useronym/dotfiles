#!/usr/bin/env bash

while read lidstate < '/proc/acpi/button/lid/LID/state'
do
    sleep 1
    if [[ "$lidstate" != "$oldstate" ]]; then
        if [[ "$lidstate" = *closed* ]]; then
            pidof i3lock || lock
            ac_adapter=$(acpi -a | cut -d' ' -f3 | cut -d- -f1)
            if [ "$ac_adapter" = "on" ]; then
                xset dpms force off
            else
                systemctl suspend
            fi
        else
            xset dpms force on
        fi
    fi

    oldstate=$lidstate
done
