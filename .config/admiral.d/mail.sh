#!/usr/bin/env bash

source "colors.sh"

MAIL=$(mailcheck -c)
if [ "$MAIL" != "" ]; then
    MAILS=$(echo $MAIL | cut -d " " -f 3)
    echo -ne "%{B$c_bg} %{T2}\ue1a8%{T1}%{B-} $MAILS new "
fi
