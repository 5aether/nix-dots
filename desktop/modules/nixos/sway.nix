{ pkgs, ... }:

{
  # sddm
  services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    # gnome keyrings
    gnome.gnome-keyring.enable = true;
  };

  # sway
  programs.sway = {
    enable = true;
    extraOptions = [ "--unsupported-gpu" ];
  };

  # polkit
  security.polkit.enable = true;
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";

    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];

    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  }; 

  # portal
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];

    wlr.settings = {
      screencast = {
        chooser_type = "simple";
        chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";

        cursor_mode = "embedded";

        max_fps = 144;
      };
    };

    config = {
      common = {
        default = [ "gtk" ];
      };
      sway = {
        default = [ "gtk" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
      };
    };
  };

  services.dbus.implementation = "broker";
}
