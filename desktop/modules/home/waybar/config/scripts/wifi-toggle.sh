if command -v nmcli >/dev/null 2>&1; then
    if [ "$(nmcli radio wifi 2>/dev/null)" = "enabled" ]; then
        nmcli radio wifi off
    else
        nmcli radio wifi on
    fi
elif command -v rfkill >/dev/null 2>&1; then
    if rfkill list wifi 2>/dev/null | grep -q "Soft blocked: no"; then
        rfkill block wifi
    else
        rfkill unblock wifi
    fi
else
    for iface in /sys/class/net/*; do
        name=$(basename "$iface")
        [ -d "$iface/wireless" ] || continue
        if [ "$(cat /sys/class/net/$name/operstate 2>/dev/null)" = "up" ]; then
            ip link set "$name" down
        else
            ip link set "$name" up
        fi
    done
fi
