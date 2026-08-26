swaync-client -d
PID=$(cat "${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/waybar-swaync.pid" 2>/dev/null)
if [ -n "$PID" ] && kill -0 "$PID" 2>/dev/null; then
    kill -USR1 "$PID"
fi