find_eth_iface() {
    for iface in /sys/class/net/*; do
        local name=$(basename "$iface")
        [ "$name" = "lo" ] && continue
        [ -d "$iface/wireless" ] && continue
        echo "$name"
        return 0
    done
    return 1
}

iface=$(find_eth_iface)
[ -z "$iface" ] && exit 1

has_ip() {
    ip -4 addr show "$1" 2>/dev/null | grep -q "inet "
}

if command -v nmcli >/dev/null 2>&1; then
    if has_ip "$iface"; then
        nmcli device disconnect "$iface" 2>/dev/null
    else
        uuid=$(nmcli -t -f UUID,TYPE connection show 2>/dev/null | awk -F: '$2 == "802-3-ethernet" {print $1; exit}')
        if [ -n "$uuid" ]; then
            nmcli connection up uuid "$uuid" 2>/dev/null
        else
            nmcli device connect "$iface" 2>/dev/null
        fi
    fi
else
    if has_ip "$iface"; then
        ip link set "$iface" down
    else
        ip link set "$iface" up
        if command -v dhcpcd >/dev/null 2>&1; then
            dhcpcd -n "$iface" 2>/dev/null
        elif command -v dhclient >/dev/null 2>&1; then
            dhclient "$iface" 2>/dev/null
        fi
    fi
fi
