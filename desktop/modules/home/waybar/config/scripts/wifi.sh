#!/bin/sh

output() {
    local text="$1"
    local class="$2"
    printf '{"text": "%s", "class": "%s"}\n' "$text" "$class"
}

has_wifi_hardware() {
    for iface in /sys/class/net/*; do
        [ -d "$iface/wireless" ] && return 0
    done
    return 1
}

is_wifi_off() {
    if command -v nmcli >/dev/null 2>&1; then
        [ "$(nmcli radio wifi 2>/dev/null)" = "disabled" ] && return 0
        return 1
    fi
    if command -v rfkill >/dev/null 2>&1; then
        rfkill list wifi 2>/dev/null | grep -q "Soft blocked: yes" && return 0
        rfkill list wifi 2>/dev/null | grep -q "Hard blocked: yes" && return 0
        return 1
    fi
    return 1
}

get_wifi() {
    has_wifi_hardware || { output "" "none"; return; }

    if is_wifi_off; then
        output "Wi-Fi Off 󰤭 " "off"
        return
    fi

    for iface in /sys/class/net/*; do
        local name=$(basename "$iface")
        [ -d "$iface/wireless" ] || continue
        [ "$(cat "/sys/class/net/$name/operstate" 2>/dev/null)" = "up" ] || continue

        local ssid=$(iwgetid -r "$name" 2>/dev/null)
        [ -z "$ssid" ] && ssid=$(iw dev "$name" link 2>/dev/null | grep -oP 'SSID: \K.*')
        [ -z "$ssid" ] && ssid="Unknown"

        local icon="󰤯 "
        local signal_dbm=$(iw dev "$name" station dump 2>/dev/null | grep "signal:" | head -1 | awk '{print $2}')

        if [ -n "$signal_dbm" ]; then
            if [ "$signal_dbm" -ge -50 ]; then     icon="󰤨 "
            elif [ "$signal_dbm" -ge -60 ]; then    icon="󰤥 "
            elif [ "$signal_dbm" -ge -70 ]; then    icon="󰤢 "
            elif [ "$signal_dbm" -ge -80 ]; then    icon="󰤟 "
            fi
        else
            local qual=$(awk -v ifc="$name:" '$1 == ifc {print int($3)}' /proc/net/wireless 2>/dev/null | tr -d '.')
            if [ -n "$qual" ]; then
                if [ "$qual" -ge 56 ]; then     icon="󰤨 "
                elif [ "$qual" -ge 42 ]; then   icon="󰤥 "
                elif [ "$qual" -ge 28 ]; then   icon="󰤢 "
                elif [ "$qual" -ge 14 ]; then   icon="󰤟 "
                fi
            fi
        fi

        output "$ssid $icon" "connected"
        return
    done

    output "Wi-Fi On 󱚼 " "on"
}

get_wifi

stdbuf -oL ip monitor 2>/dev/null | while true; do
    if IFS= read -r -t 3 line; then
        get_wifi
    else
        get_wifi
    fi
done
