output() {
    local text="$1"
    local class="$2"
    printf '{"text": "%s", "class": "%s"}\n' "$text" "$class"
}

has_active_wifi() {
    for iface in /sys/class/net/*; do
        local name=$(basename "$iface")
        [ -d "$iface/wireless" ] || continue
        [ "$(cat "/sys/class/net/$name/operstate" 2>/dev/null)" = "up" ] && return 0
    done
    return 1
}

get_eth() {
    for iface in /sys/class/net/*; do
        local name=$(basename "$iface")
        [ "$name" = "lo" ] && continue
        [ -d "$iface/wireless" ] && continue

        local state=$(cat "/sys/class/net/$name/operstate" 2>/dev/null)
        [ "$state" = "up" ] || continue

        if ip -4 addr show "$name" 2>/dev/null | grep -q "inet "; then
            output "Ethernet 󰈀 " "connected"
            return
        fi
    done

    if ! has_active_wifi; then
        output "Disconnected 󰈂 " "disconnected"
        return
    fi

    output "" "none"
}

get_eth

stdbuf -oL ip monitor link address route 2>/dev/null | while true; do
    if IFS= read -r -t 3 line; then
        get_eth
    else
        get_eth
    fi
done
