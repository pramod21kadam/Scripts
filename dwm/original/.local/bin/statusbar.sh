#!/bin/bash

# ! #/usr/bin/env bash

PID=$(< $HOME/.config/dwm/statusbar.pid)
if [[ $PID ]]; then
	processName=$(ps -p $PID -o comm=)
	if [[ $processName == "statusbar.sh" ]]; then
		kill $PID
		echo "killed $PID"
	fi
fi
echo $$ > $HOME/.config/dwm/statusbar.pid

battery(){
	BatteryStatus="$(cat /sys/class/power_supply/BAT0/status)"
	if [[ $BatteryStatus == "Charging" ]]; then
		echo "  $(cat /sys/class/power_supply/BAT0/capacity) " 
	else
		echo "   $(cat /sys/class/power_supply/BAT0/capacity) " 
	fi
}

brightness_level(){
	echo " $( printf "%.0f" $( light -G ))"
}

volume(){
	vol=$(awk -F"[][]" '/dB/ { print $2 }' <(amixer get Master))
	vol=${vol:0:-1}
	echo "   $vol "
}

ram_usage(){
	echo "  $(free -hm | grep Me | awk '{print($3)}') "
}

get_network(){
	Network=$(iwgetid -r)
	if [[ $Network ]]; then
		echo "   ${Network:0:1} "
	else
    		echo ""
	fi
}
get_newtorkSpeed(){
	# cat /proc/net/dev
	echo ""
}
get_cpuUsage(){
	echo "  "
}

while [ true ] 
do
	Date=$(date +"%a %d %b %I:%M %p")
	Cpu=" $(cat /sys/class/hwmon/hwmon4/temp1_input | cut -c 1-2)  "
	output="    $(volume) $(battery) $(brightness_level) $(ram_usage) $(get_network) $Cpu | $Date "
	xsetroot -name "$output"
	sleep 30
done
