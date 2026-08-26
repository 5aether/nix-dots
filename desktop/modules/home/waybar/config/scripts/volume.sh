cleanup() {
    kill $(jobs -p) 2>/dev/null
    wait 2>/dev/null
    exit 0
}
trap cleanup INT TERM EXIT

get_state() {
    local out vol muted
    out=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)
    
    if [ -z "$out" ]; then
        echo "0 1"
        return
    fi
    
    [[ "$out" == *"[MUTED]"* ]] && muted=1 || muted=0
    
    vol=${out#Volume: }
    vol=${vol%% *}
    vol=${vol//./}
    vol=$((10#$vol))
    [ "$vol" -gt 100 ] && vol=100
    
    echo "$vol $muted"
}

output() {
    local vol muted
    read -r vol muted <<< "$(get_state)"
    
    if [ "$muted" -eq 1 ]; then
        printf '{"text":"0%%  ","tooltip":"Muted","class":"muted"}\n'
    elif [ "$vol" -eq 0 ]; then
        printf '{"text":"0%%  ","tooltip":"Volume: 0%%","class":"volume"}\n'
    else
        local icon
        if [ "$vol" -le 33 ]; then icon=" "
        elif [ "$vol" -le 66 ]; then icon=" "
        else icon=" "
        fi
        printf '{"text":"%s%% %s","tooltip":"Volume: %s%%","class":"volume"}\n' "$vol" "$icon" "$vol"
    fi
}

output

while true; do
    if command -v stdbuf >/dev/null 2>&1; then
        stdbuf -oL pactl subscribe 2>/dev/null
    else
        pactl subscribe 2>/dev/null
    fi | while IFS= read -r line; do
        case "$line" in
            *"Event 'change' on sink #"*|*"Event 'new' on sink #"*|*"Event 'change' on server"*)
                output
                ;;
        esac
    done
done