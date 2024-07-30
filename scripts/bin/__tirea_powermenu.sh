#!/bin/sh

case "$(echo -e "Cancel\nShutdown\nRestart\nSuspend\nExit" | dmenu \
    -sb "#ee5396" \
    -p \
    "Power " -l 5)" in
        Shutdown) exec systemctl poweroff;;
        Restart) exec systemctl reboot;;
        Suspend) exec systemctl suspend;;
		Exit) exec pkill -u $USER;;
esac
