PLAYER=$(cat "${XDG_RUNTIME_DIR:-/tmp}/waybar-player-active" 2>/dev/null)
[ -z "$PLAYER" ] && exit 1
playerctl -p "$PLAYER" "$1"
