#!/bin/bash

launch-rofi() {
    rofi -dmenu -p "$MESSAGE" -sep "|" -theme powermenu
}

poweroff() {
    systemctl poweroff
}

reboot() {
    systemctl reboot
}

logout() {
    hyprctl dispatch exit
}

lock() {
    sleep .2 && hyprlock
}

suspend() {
    systemctl suspend && hyprlock
}

powermenu() {
    MESSAGE="Que hem de fer?"
    POWER=" "
    RESTART=" "
    LOGOUT=" "
    LOCK=" "
    SUSPEND=" "

    RES=$(echo "$LOCK|$SUSPEND|$POWER|$RESTART|$LOGOUT" | launch-rofi)

    case "$RES" in
    "$POWER")
        poweroff
        ;;
    "$RESTART")
        reboot
        ;;
    "$LOGOUT")
        logout
        ;;
    "$LOCK")
        lock
        ;;
    "$SUSPEND")
        suspend
        ;;
    "")
        exit 0
        ;;
    *)
        exit 1
        ;;
    esac
}

powermenu
