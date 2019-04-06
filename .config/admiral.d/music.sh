#!/usr/bin/env bash

input=$(cmus-remote -Q)

#if [[ $? -ne 0 ]]; then
#    exit;

function tag {
    line=$(echo "$input" | grep "tag $1" | head -n 1)
    echo $(echo $line | cut -d ' ' -f 3-)
}

printf "%s - %s (%s) %s" "$(tag artist)" "$(tag title)" "$(tag album)" $(tag year)
