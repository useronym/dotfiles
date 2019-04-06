#!/usr/bin/env bash

function tag {
    line=$(echo "$input" | grep "tag $1" | head -n 1)
    echo $(echo $line | cut -d ' ' -f 3-)
}

if [ "$(pidof cmus)" ]; then
    input=$(cmus-remote -Q)
    printf "%s - %s (%s) %s" "$(tag artist)" "$(tag title)" "$(tag album)" $(tag year)
fi
