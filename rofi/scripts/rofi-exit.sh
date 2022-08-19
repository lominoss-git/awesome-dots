#!/usr/bin/env bash

CHOICE=$(printf "%s\n" "Lock" "Sleep" "Logout" "Restart" "Shutdown" | rofi -i -dmenu -p "Exit")

case "$CHOICE" in
	"Lock") slimlock ;;
	"Sleep") CONFIRM=$(printf '%s\n' "No" "Yes, sleep" | rofi -i -dmenu -p "Sleep" -theme-str ' textbox-prompt-divider { str: "? "; } ') ;;
	"Logout") CONFIRM=$(printf '%s\n' "No" "Yes, logout" | rofi -i -dmenu -p "Logout" -theme-str ' textbox-prompt-divider { str: "? "; } ') ;;
	"Restart") CONFIRM=$(printf '%s\n' "No" "Yes, restart" | rofi -i -dmenu -p "Restart" -theme-str ' textbox-prompt-divider { str: "? "; } ') ;;
	"Shutdown") CONFIRM=$(printf '%s\n' "No" "Yes, shutdown" | rofi -i -dmenu -p "Shutdown" -theme-str ' textbox-prompt-divider { str: "? "; } ') ;;
esac

case "$CONFIRM" in
	"Yes, sleep") systemctl sleep ;;
	"Yes, logout") echo "awesome.quit()" | awesome-client ;;
	"Yes, restart") systemctl reboot ;;
	"Yes, shutdown") systemctl poweroff ;;
esac
