#!/usr/bin/env bash

# Brightness script that changes the brightness of Screen

brightness_level=$( printf "%.0f" $(light -G) )
echo $$
if [[ $1 == "down" ]]; then
   if [[ $brightness_level -le 5 ]]; then
        light -S 1
    else
        light -U 5
    fi
else
	if [[ $1 == "up" ]]; then
		light -A 5
    	else
		light -G
	fi
fi

statusbar.sh & 
disown
exit
