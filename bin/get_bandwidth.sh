#!/usr/bin/env bash

INTERFACE="wlp2s0"
FILE="/tmp/$INTERFACE-bandwidth"

# Get current values
vals=$(cat /proc/net/dev | grep $INTERFACE | sed -r 's/[ \t]+/ /g' | cut -d ' ' -f 2,10)

# Check if temp file exists
if [ ! -f $FILE ]; then
    echo $vals > $FILE
    echo "0 0"
    exit 0
fi

# Parse current values.
down=$(echo $vals | cut -d ' ' -f 1)
up=$(echo $vals | cut -d ' ' -f 2)

# Get previous values
prev=$(cat $FILE)
down_prev=$(echo $prev | cut -d ' ' -f 1)
up_prev=$(echo $prev | cut -d ' ' -f 2)

# Calculate difference.
down_diff=$(($down - $down_prev))
up_diff=$(($up - $up_prev))

# Update file.
echo $vals > $FILE

# Print diff.
echo "$down_diff $up_diff"
