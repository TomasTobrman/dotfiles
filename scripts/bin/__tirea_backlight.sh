#!/bin/bash

if [ "$#" -ne 2 ]; then
	exit 1
fi

function send_notification {
	icon="$HOME/.config/dunst/assets/backlight_$1.svg"
	value=$(xbacklight -ctrl $device -get)
	count=$((value / 5))
	bar=$(seq -s "█" 0 $count | sed 's/[0-9]//g' | awk '{printf "%-20s", $1}')
	percent=$(echo $value | awk '{printf "%3s%%", $1}')
	dunstify -i $icon -r 5551 "Backlight" "$bar  $percent"
}

case $1 in
	mon) device=acpi_video0;;
	kbd) device=smc::kbd_backlight;;
	*) exit 2;;
esac

case $2 in
	up)
		sudo xbacklight -ctrl $device -inc 5 -time 0
		send_notification $1
		;;
	down)
		sudo xbacklight -ctrl $device -dec 5 -time 0
		send_notification $1
		;;
esac
