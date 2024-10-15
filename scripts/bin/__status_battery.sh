#!/bin/sh

# Loop through all attached batteries.
battery=/sys/class/power_supply/BAT0

charge_now=$(cat "$battery/charge_now" 2>&1)
charge_full=$(cat "$battery/charge_full" 2>&1)
charge_full_design=$(cat "$battery/charge_full_design" 2>&1)

capacity="$(expr $(expr $charge_now \* 100) / $charge_full)"
capacity_max="$(expr $(expr $charge_full \* 100) / $charge_full_design)"
capacity_real=$(cat "$battery/capacity" 2>&1)

if   [ "$capacity" -gt 90 ]; then status="󰁹"
elif [ "$capacity" -gt 80 ]; then status="󰂂"
elif [ "$capacity" -gt 70 ]; then status="󰂂"
elif [ "$capacity" -gt 60 ]; then status="󰂀"
elif [ "$capacity" -gt 50 ]; then status="󰁿"
elif [ "$capacity" -gt 40 ]; then status="󰁾"
elif [ "$capacity" -gt 30 ]; then status="󰁽"
elif [ "$capacity" -gt 20 ]; then status="󰁼"
elif [ "$capacity" -gt 10 ]; then status="󰁻"
else                              status="󰁺"
fi

bg="#161616"
fg="#525252"

case "$(cat "$battery/status" 2>&1)" in
	Full)
		status="󰂄"
		bg="#33b1ff"
		fg="#161616"
		;;
	Discharging)
		if [ "$capacity" -le 20 ]; then
			status=" $status"
			bg="#ee5396"
			fg="#161616"
		fi
		;;
	Charging)
		status="󰚥 $status"
		bg="#262626"
		fg="#3ddbd9"
		;;
	"Not charging") status="" ;;
	Unknown) status="? $status" ;;
	*) exit 1 ;;
esac

__status_block.sh "$status" "$capacity% ($capacity_real/$capacity_max)" "$bg" "$fg"

