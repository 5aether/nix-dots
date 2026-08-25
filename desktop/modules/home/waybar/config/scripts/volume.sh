#!/bin/sh

output() {
    local text="$1"
    local class="$2"
    printf '{"text": "%s", "class": "%s"}\n' "$text" "$class"
}

get_volume() {
    local sink_info
    sink_info=$(pactl list sinks 2>/dev/null | grep -A 10 "Name: $(pactl info 2>/dev/null | grep 'Default Sink:' | cut -d: -f2 | xargs)")

    if [ -z "$sink_info" ]; then
        output "0%  " "muted"
        return
    fi

    local mute=$(echo "$sink_info" | grep "Mute:" | head -1 | awk '{print $2}')
    local vol=$(echo "$sink_info" | grep "Volume:" | head -1 | grep -oP '\d+(?=%)' | head -1)

    [ -z "$vol" ] && vol=0

    if [ "$mute" = "yes" ]; then
        output "$vol%  " "muted"
        return
    fi

    local icon=""
    if [ "$vol" -gt 75 ]; then
        icon=" "
    elif [ "$vol" -gt 50 ]; then
        icon=" "
    elif [ "$vol" -gt 25 ]; then
        icon=" "
    fi

    output "$vol% $icon" "normal"
}

get_volume

pactl subscribe 2>/dev/null | grep --line-buffered -E "('change' on sink|on server)" | while read -r line; do
    get_volume
done
