#!/bin/bash

# See README.md for usage instructions
BAR_COLOR="#B3CFA7"
VOLUME_STEP=5
MAX_VOLUME=100
BRIGHTNESS_STEP=5

function get_volume {
    pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '[0-9]{1,3}(?=%)' | head -1
}

function get_mute {
    pactl get-sink-mute @DEFAULT_SINK@ | grep -Po '(?<=Mute: )(sí|no)'
}

function get_brightness_level {
    # TODO: ???
    printf "%.0f\n" "$(xbacklight)"
}

function get_volume_icon {
    VOLUME=$(get_volume)
    MUTE=$(get_mute)
    if [ "$VOLUME" -eq 0 ] || [ "$MUTE" == "sí" ]; then
        VOLUME_ICON=" "
    elif [ "$VOLUME" -lt 50 ]; then
        VOLUME_ICON=" "
    else
        VOLUME_ICON=" "
    fi
}

function get_brightness_icon {
    if [ "$1" = "up" ]; then
        BRIGHTNESS_ICON="🔆"
    else
        BRIGHTNESS_ICON="🔅"
    fi
}

function show_volume_notif {
    VOLUME=$(get_mute)
    get_volume_icon
    dunstify \
        -i audio-volume-muted-blocking \
        -t 1000 \
        -r 2593 \
        -u normal "$VOLUME_ICON $VOLUME%" \
        -h "int:value:$VOLUME" \
        -h "string:hlcolor:$BAR_COLOR"
}

function show_brightness_notif {
    LEVEL=$(get_brightness_level)
    dunstify \
        -t 1000 \
        -r 2594 \
        -u normal "$BRIGHTNESS_ICON" "$LEVEL%" \
        -h "int:value:$LEVEL" \
        -h "echoistring:hlcolor:$BAR_COLOR"
}

case $1 in
volume_up)
    pactl set-sink-mute @DEFAULT_SINK@ 0
    VOLUME=$(get_volume)
    if [ $(("$VOLUME" + "$VOLUME_STEP")) -gt $MAX_VOLUME ]; then
        pactl set-sink-volume @DEFAULT_SINK@ $MAX_VOLUME%
    else
        pactl set-sink-volume @DEFAULT_SINK@ +$VOLUME_STEP%
    fi
    show_volume_notif
    ;;

volume_down)
    pactl set-sink-volume @DEFAULT_SINK@ -$VOLUME_STEP%
    show_volume_notif
    ;;

volume_mute)
    pactl set-sink-mute @DEFAULT_SINK@ toggle
    show_volume_notif
    ;;
brightness_up)
    xbacklight -inc $BRIGHTNESS_STEP
    get_brightness_icon "up"
    show_brightness_notif
    ;;
brightness_down)
    xbacklight -dec $BRIGHTNESS_STEP
    get_brightness_icon "down"
    show_brightness_notif
    ;;
esac
