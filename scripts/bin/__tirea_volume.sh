#!/bin/bash

if [ "$#" -ne 1 ]; then
	exit 1
fi

function send_notification {
	icon="$HOME/.config/dunst/assets/volume.svg"
	value=$(amixer get Master | grep -oP '\[[0-9]+\%\]' | grep -oP '[0-9]+' | head -1)
	count=$((value / 5))
	bar=$(seq -s "█" 0 $count | sed 's/[0-9]//g' | awk '{printf "%-20s", $1}')
	percent=$(echo $value | awk '{printf "%3d%%", $1}')
	dunstify -i $icon -r 5551 "Volume" "$bar  $percent"
}

case $1 in
	up)
		amixer -q set Master 5%+
		send_notification
		;;
	down)
		amixer -q set Master 5%-
		send_notification
		;;
	mute)
		amixer -q set Master 0
		send_notification
esac

