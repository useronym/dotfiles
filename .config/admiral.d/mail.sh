#!/usr/bin/env bash

MAIL=$(mailcheck -c)
if [ "$MAIL" != "" ]; then
    MAILS=$(echo $MAIL | cut -d " " -f 3)
    echo -ne "%{T2}\uf0e0%{T1} $MAILS new"
fi
