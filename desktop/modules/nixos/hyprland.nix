{ pkgs, ... }:

{
  services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    gnome.gnome-keyring.enable = true;
  };

  programs = {
    uwsm.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
      withUWSM = true;
    };
  };

  security.polkit.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
    config.hyprland = {
      "org.freedesktop.impl.portal.FileChooser" = [ "gnome" ];
    };
  };

  systemd.user.services.hypr-scheme-watcher = {
    description = "caelestia's hyprland scheme watcher";
    wantedBy = [ "default.target" ];
    after = [ "default.target" ];

    serviceConfig = {
      Type = "simple";
      ExecStart = pkgs.writeShellScript "hypr-scheme-watcher" ''
        SCHEME_DIR="/home/aether/.config/hypr/scheme"
        SCHEME_FILE="current.lua"

        while [ ! -f "$SCHEME_DIR/$SCHEME_FILE" ]; do
          sleep 2
        done

        ${pkgs.inotify-tools}/bin/inotifywait -m -e close_write,moved_to "$SCHEME_DIR" |
        while read -r directory events filename; do
          if [ "$filename" = "$SCHEME_FILE" ]; then
            ${pkgs.hyprland}/bin/hyprctl reload
          fi
        done
      '';
      Restart = "on-failure";
      RestartSec = 5;
    };
  };
}
