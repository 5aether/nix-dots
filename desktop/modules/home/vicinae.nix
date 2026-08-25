{
  programs.vicinae = {
    enable = true;
    settings = {
      "$schema" = "https://vicinae.com/schemas/config.json";
      pop_to_root_on_close = true;
      activate_on_single_click = true;
      escape_key_behavior = "close_window";
      font = {
        rendering = "native";
        normal = {};
      };
      theme = {
        dark = {
          name = "rose-pine";
          icon_theme = "rose-pine";
        };
      };
      launcher_window = {
        opacity = 0.9;
        compact_mode = {
          enabled = true;
        };
      };
      providers = {
        "@Gelei/store.vicinae.bluetooth" = {
          preferences = {
            connectionToggleable = true;
          };
        };
        "@leiserfg/store.vicinae.ssh" = {
          preferences = {
            terminal = "foot";
          };
        };
        "@leonkohli/store.vicinae.process-manager" = {
          entrypoints = {
            kill = {
              enabled = false;
            };
          };
        };
        applications = {
          preferences = {
            defaultAction = "focus";
            paths = [];
          };
          entrypoints = {
            vicinae = {
              enabled = false;
            };
          };
        };
        "browser-extension" = {
          enabled = false;
          entrypoints = {
            "browse-tabs" = {
              enabled = false;
            };
          };
        };
        calculator = {
          entrypoints = {
            history = {
              enabled = true;
            };
            "refresh-rates" = {
              enabled = false;
            };
          };
        };
        clipboard = {
          preferences = {
            eraseOnStartup = false;
            ignorePasswords = false;
            monitoring = true;
          };
          entrypoints = {
            clear = {
              enabled = false;
            };
            "clear-history" = {
              enabled = false;
            };
            history = {
              enabled = false;
            };
          };
        };
        core = {
          entrypoints = {
            "list-extensions" = {
              enabled = false;
            };
            "manage-fallback" = {
              enabled = false;
            };
            "open-config-file" = {
              enabled = false;
            };
            "open-default-config" = {
              enabled = false;
            };
            "reload-scripts" = {
              enabled = false;
            };
            "report-bug" = {
              enabled = false;
            };
            "search-emojis" = {
              enabled = false;
            };
            settings = {
              enabled = false;
            };
            "show-logs" = {
              enabled = false;
            };
            sponsor = {
              enabled = false;
            };
          };
        };
        developer = {
          enabled = false;
        };
        files = {
          preferences = {
            autoIndexing = true;
            excludedIndexingPaths = [];
            indexingPaths = [
              "/home/aether/"
              "/bin"
              "/etc"
              "/usr"
              "/opt"
              "/mnt"
              "/media"
              "/lib64"
              "/lib"
            ];
          };
          entrypoints = {
            search = {
              enabled = true;
            };
          };
        };
        font = {
          enabled = false;
        };
        "manage-shortcuts" = {
          enabled = false;
        };
        power = {
          entrypoints = {
            hibernate = {
              enabled = false;
            };
            "power-off" = {
              enabled = true;
            };
            "soft-reboot" = {
              enabled = false;
            };
            suspend = {
              enabled = false;
            };
          };
        };
        "raycast-compat" = {
          enabled = false;
          entrypoints = {
            store = {
              enabled = true;
            };
          };
        };
        snippets = {
          enabled = false;
        };
        system = {
          enabled = false;
          entrypoints = {
            run = {
              enabled = false;
            };
          };
        };
        theme = {
          enabled = false;
        };
        wm = {
          enabled = false;
        };
      };
    };
  };
}
