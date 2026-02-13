#!/bin/bash
# A script that uses variables and user input.

# Variables
NAME="World"
HOUR=$(date +%H)

# Determine greeting based on time of day
if [ "$HOUR" -lt 12 ]; then
    TIME_OF_DAY="morning"
elif [ "$HOUR" -lt 17 ]; then
    TIME_OF_DAY="afternoon"
else
    TIME_OF_DAY="evening"
fi

echo "Good $TIME_OF_DAY, $NAME!"
echo "The current time is $(date +%H:%M)."
echo ""
echo "Try modifying the NAME variable in this script to use your own name!"
