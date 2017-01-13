#!/usr/bin/env bash

. config.sh

echo -ne $(date "+%{B${config_primary:1:-1}}%{T2} \ue151%{T1}%{B-} %a %B %-d  %H:%M") " "
