#!/bin/sh

# Read system files every min to and update "Battery" and "Cpu"
# Battery="$(cat /sys/class/power_supply/BAT0/capacity)" 
# Cpu=$(cat /sys/class/hwmon/hwmon4/temp1_input | cut -c 1-2)

while [ true ] 
do
	Date=$(date +"%a %d %b %I:%M %p")
	Network=$(iwgetid -r)
	
	Battery="$(cat /sys/class/power_supply/BAT0/capacity)" 
	Cpu=$(cat /sys/class/hwmon/hwmon4/temp1_input | cut -c 1-2)

	output="[ BAT $Battery% ] [ CPU $Cpu ] [ $Network ] [ $Date ]"
	xsetroot -name "$output"
	sleep 30
done &

# while [ true ]
# do
# 	let Battery="$(cat /sys/class/power_supply/BAT0/capacity)" 
# 	let Cpu=$(cat /sys/class/hwmon/hwmon4/temp1_input | cut -c 1-2)
#	sleep 1m
# done &
