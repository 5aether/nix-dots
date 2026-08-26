FIFO="${XDG_RUNTIME_DIR:-/tmp}/waybar-player-$$.fifo"
ACTIVE_FILE="${XDG_RUNTIME_DIR:-/tmp}/waybar-player-active"

cleanup() {
    rm -f "$FIFO" "$ACTIVE_FILE"
    kill $(jobs -p) 2>/dev/null
    wait 2>/dev/null
    exit 0
}
trap cleanup INT TERM EXIT

get_best_player() {
    local players status
    players=$(timeout 2 playerctl -l 2>/dev/null)
    [ -z "$players" ] && return
    while IFS= read -r player; do
        [ -z "$player" ] && continue
        status=$(timeout 1 playerctl -p "$player" status 2>/dev/null)
        [ "$status" = "Playing" ] && { echo "$player"; return; }
    done <<< "$players"
    echo "$players" | head -n1
}

output() {
    local status="$1" meta="$2"
    if [ -z "$meta" ] || [ "$meta" = " - " ] || [ "$status" = "Stopped" ] || [ -z "$status" ]; then
        printf '{"text":""}\n'
        return
    fi
    if [ "$status" = "Playing" ]; then
        jq -n -c --arg text "$meta" '{text: $text}'
    else
        jq -n -c --arg text "$meta" '{text: $text, class: "paused"}'
    fi
}

CURRENT_PLAYER=""
LAST_OUTPUT=""

update() {
    local best status meta out
    best=$(get_best_player)

    if [ -z "$best" ]; then
        if [ -n "$CURRENT_PLAYER" ]; then
            printf '{"text":""}\n'
            CURRENT_PLAYER=""
            LAST_OUTPUT=""
            rm -f "$ACTIVE_FILE"
        fi
        return
    fi

    CURRENT_PLAYER="$best"
    echo "$best" > "$ACTIVE_FILE"
    status=$(timeout 1 playerctl -p "$best" status 2>/dev/null)
    meta=$(timeout 1 playerctl -p "$best" metadata --format '{{title}} - {{artist}}' 2>/dev/null)

    out=$(output "$status" "$meta")
    if [ "$out" != "$LAST_OUTPUT" ]; then
        printf '%s\n' "$out"
        LAST_OUTPUT="$out"
    fi
}

update

while true; do
    rm -f "$FIFO"
    mkfifo "$FIFO" 2>/dev/null || { sleep 1; continue; }

    if command -v dbus-monitor >/dev/null 2>&1; then
        stdbuf -oL dbus-monitor --session "type='signal',interface='org.freedesktop.DBus.Properties',member='PropertiesChanged',path='/org/mpris/MediaPlayer2'" 2>/dev/null > "$FIFO" &
        MON_PID=$!

        while IFS= read -r _ < "$FIFO"; do
            update
        done

        kill $MON_PID 2>/dev/null
        wait $MON_PID 2>/dev/null
    fi

    sleep 0.5
done
