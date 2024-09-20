#!/bin/sh

# Loop through all attached batteries.
battery=/sys/class/power_supply/BAT0
capacity="$(cat "$battery/capacity" 2>&1)"
if [ "$capacity" -gt 90 ]; then
	status=""
elif [ "$capacity" -gt 60 ]; then
	status=""
elif [ "$capacity" -gt 40 ]; then
	status=""
elif [ "$capacity" -gt 10 ]; then
	status=""
else
	status=""
fi

bg="#262626"
fg="#ffffff"

case "$(cat "$battery/status" 2>&1)" in
	Full) status="" ;;
	Discharging)
		if [ "$capacity" -le 20 ]; then
			status=" $status"
			bg="#ee5396"
			fg="#161616"
		fi
		;;
	Charging) status="󰚥 $status" ;;
	"Not charging") status="" ;;
	Unknown) status="? $status" ;;
	*) exit 1 ;;
esac

__status_block.sh "$status" "$capacity%" "$bg" "$fg"

