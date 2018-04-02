#!/usr/bin/env bash

source "colors.sh"

MAIL=$(mailcheck -c)
if [ "$MAIL" != "" ]; then
    MAILS=$(echo $MAIL | cut -d " " -f 3)
    echo -ne "%{R} %{T2}\ue1a8%{T1}%{R} $MAILS new "
fi
