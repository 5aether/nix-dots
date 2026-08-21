{
  programs.caelestia = {
    enable = true;
    systemd = {
      enable = true;
      target = "graphical-session.target";
      environment = [
        "QT_QPA_PLATFORMTHEME=gtk3"
      ]; 
    };

    settings = {
      paths.wallpaperDir = "/home/aether/nix-dots/wallpapers/";

      appearance = {
        transparency = {
          enabled = true;
        };
      };

      background = {
        wallpaperEnabled = true;
      };

      bar = {
        activeWindow = {
          compact = true;
          inverted = false;
          showOnHover = true;
        };
        persistent = true;
        popouts = {
          tray = true;
        };
        showOnHover = true;
        statusIcons = [
          { enabled = true; id = "lockStatus"; }
          { enabled = false; id = "microphone"; }
          { enabled = true; id = "audio"; }
          { enabled = false; id = "kbLayout"; }
          { enabled = true; id = "network"; }
          { enabled = true; id = "bluetooth"; }
          { enabled = false; id = "battery"; }
        ];
        tray = {
          background = false;
          compact = true;
          recolour = false;
        };
        workspaces = {
          activeIndicator = true;
          activeTrail = false;
          occupiedBg = false;
          perMonitorWorkspaces = false;
          showWindows = false;
          showWindowsOnSpecialWorkspaces = false;
          shown = 5;
        };
      };

      dashboard = {
        performance = {
          showBattery = false;
          showStorage = false;
        };
      };

      general = {
        apps = {
          explorer = [ "nautilus" "--new-window" ];
          terminal = [ "kitty" ];
        };
      };

      launcher = {
        actionPrefix = ".";
        showOnHover = true;
        useFuzzy = {
          actions = false;
          apps = true;
          schemes = false;
          wallpapers = true;
        };
      };

      services = {
        defaultPlayer = "Feishin";
        lyricsBackend = "LRCLIB";
        useFahrenheit = false;
      };

      sidebar = {
        enabled = true;
      };

      utilities = {
        cards = {
          keepAwake = false;
        };
        quickToggles = [
          { enabled = true; id = "wifi"; }
          { enabled = true; id = "bluetooth"; }
          { enabled = true; id = "mic"; }
          { enabled = true; id = "settings"; }
          { enabled = true; id = "gameMode"; }
          { enabled = true; id = "dnd"; }
          { enabled = false; id = "vpn"; }
        ];
        toasts = {
          chargingChanged = true;
          fullscreen = "important";
          nowPlaying = true;
        };
      };
    };

    cli = {
      enable = true;
      settings = {
        theme.enableGtk = true;
      };
    };
  };

  programs.swappy = {
    enable = true;
    settings = {
      Default = {
        save_dir = "$HOME/Pictures/Screenshots/";
        save_filename_format = "Screenshot-%Y%m%d-%H%M%S.png";
      };
    };
  };
}
