{ lib, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    systemd.enable = true;
    wrapperFeatures.gtk = true;
    extraOptions = [ "--unsupported-gpu" ];

    config = rec {
      modifier = "Mod4";
      terminal = "foot";
      menu = "vicinae toggle";

      input = {
        "type:pointer" = {
          accel_profile = "flat";
          pointer_accel = "-0.3";
        };
        "type:keyboard" = {
          xkb_layout = "it";
        };
      };

      seat = {
        "*" = {
          xcursor_theme = "BreezeX-RosePine-Linux 16";
        };
      };

      fonts = {
        names = [ "Maple Mono NF CN" ];
        size = 10.0;
      };

      window = {
        titlebar = false;
        border = 2;
      };

      colors = {
        background = "#191724"; # base

        focused = {
          border = "#c4a7e7";       # iris
          background = "#26233a";   # overlay
          text = "#e0def4";         # text
          indicator = "#ebbcba";    # rose
          childBorder = "#c4a7e7";  # iris
        };

        focusedInactive = {
          border = "#6e6a86";       # muted
          background = "#1f1d2e";   # surface
          text = "#e0def4";         # text
          indicator = "#26233a";    # overlay
          childBorder = "#6e6a86";  # muted
        };

        unfocused = {
          border = "#26233a";       # overlay
          background = "#191724";   # base
          text = "#908caa";         # subtle
          indicator = "#1f1d2e";    # surface
          childBorder = "#26233a";  # overlay
        };

        urgent = {
          border = "#eb6f92";       # love
          background = "#eb6f92";   # love
          text = "#e0def4";         # text
          indicator = "#ebbcba";    # rose
          childBorder = "#eb6f92";  # love
        };
      };

      gaps = {
        inner = 5;
        outer = 10;
        smartGaps = false;
      };

      floating = {
        titlebar = false;
        modifier = "${modifier} normal";
      };

      output = {
        "DP-1" = {
          mode = "1920x1080@200Hz";
          position = "0 0";
          scale = "1";
        };
        "HDMI-A-1" = {
          mode = "1920x1080@144Hz";
          position = "1920 -80";
          scale = "1";
        };
      };

      workspaceOutputAssign = [
        {
          output = "DP-1";
          workspace = "1";
        }
        {
          output = "HDMI-A-1";
          workspace = "2";
        }
      ];

      keybindings = lib.mkOptionDefault {
        "${modifier}+t" = "exec ${terminal}";
        "${modifier}+c" = "kill";
        "${modifier}+r" = "exec ${menu}";
        "${modifier}+a" = "reload";
        "${modifier}+Shift+s" = "exec ast region";
        "${modifier}+i" = "exec pkill waybar && waybar";
        "Print" = "exec ast output";
        "${modifier}+l" =
          "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit'";

        "${modifier}+Prior" = "exec playerctl next";
        "${modifier}+Next" = "exec playerctl previous";
        "${modifier}+Home" = "exec playerctl play-pause";
        "${modifier}+Delete" = "exec playerctl play-pause";

        "${modifier}+Left" = "focus left";
        "${modifier}+Down" = "focus down";
        "${modifier}+Up" = "focus up";
        "${modifier}+Right" = "focus right";

        "${modifier}+Shift+Left" = "move left";
        "${modifier}+Shift+Down" = "move down";
        "${modifier}+Shift+Up" = "move up";
        "${modifier}+Shift+Right" = "move right";

        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";
        "${modifier}+0" = "workspace number 10";

        "${modifier}+Ctrl+1" = "move container to workspace number 1";
        "${modifier}+Ctrl+2" = "move container to workspace number 2";
        "${modifier}+Ctrl+3" = "move container to workspace number 3";
        "${modifier}+Ctrl+4" = "move container to workspace number 4";
        "${modifier}+Ctrl+5" = "move container to workspace number 5";
        "${modifier}+Ctrl+6" = "move container to workspace number 6";
        "${modifier}+Ctrl+7" = "move container to workspace number 7";
        "${modifier}+Ctrl+8" = "move container to workspace number 8";
        "${modifier}+Ctrl+9" = "move container to workspace number 9";
        "${modifier}+Ctrl+0" = "move container to workspace number 10";

        "${modifier}+b" = "splith";
        "${modifier}+v" = "splitv";

        "${modifier}+f" = "fullscreen";
        "${modifier}+s" = "floating toggle";
      };

      bars = [ ];
    };

    extraConfig = ''
      exec systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      exec dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      exec awt start
      exec vicinae server
      exec waybar

      bindsym --locked XF86AudioMute exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bindsym --locked XF86AudioLowerVolume exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      bindsym --locked XF86AudioRaiseVolume exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ 
    '';
  };
}
