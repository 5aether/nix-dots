#!/bin/bash

PIDFILE="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/waybar-swaync.pid"
echo $$ > "$PIDFILE"

cleanup() {
    rm -f "$PIDFILE"
    kill $(jobs -p) 2>/dev/null
    exit 0
}
trap cleanup INT TERM EXIT

output() {
    local count dnd
    count=$(swaync-client --count 2>/dev/null || echo "0")
    dnd=$(swaync-client --get-dnd 2>/dev/null | tr '[:upper:]' '[:lower:]' || echo "false")

    if ! [ "$count" -eq "$count" ] 2>/dev/null; then
        count=0
    fi

    if [ "$dnd" = "true" ]; then
        printf '{"text":"󰪓 ","class":"dnd","tooltip":"Do Not Disturb (%s notifications)"}\n' "$count"
    elif [ "$count" -gt 0 ]; then
        printf '{"text":"%s 󰅸 ","class":"notification","tooltip":"%s notifications"}\n' "$count" "$count"
    else
        printf '{"text":" ","class":"default","tooltip":"No notifications"}\n'
    fi
}

trap 'output' USR1

output

swaync-client --subscribe 2>/dev/null | while IFS= read -r _; do
    output
done