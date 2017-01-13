#!/usr/bin/env bash

. config.sh

MAIL=$(mailcheck -c)
if [ "$MAIL" != "" ]; then
    MAILS=$(echo $MAIL | cut -d " " -f 3)
    echo -ne "%{B${config_primary:1:-1}}%{T2}\ue1a8%{T1}%{B-} $MAILS new "
fi
