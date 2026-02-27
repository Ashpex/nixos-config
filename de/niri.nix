# Niri compositor with Noctalia Shell
{ config, pkgs, ... }:

{
  programs = {
    niri = {
      enable = true;
      package = pkgs.unstable.niri;
    };
  };

  services = {
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd niri-session";
          user = "greeter";
        };
      };
    };

    # Required by Noctalia (but conflicts with TLP, so use mkDefault)
    power-profiles-daemon = {
      enable = pkgs.lib.mkDefault true;
    };
    upower = {
      enable = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      unstable.noctalia-shell    # Desktop shell (Quickshell-based)
      wl-clipboard               # Clipboard
      brightnessctl              # Brightness control (used by niri keybinds)
      playerctl                  # Media player control (used by niri keybinds)
      pavucontrol                # Audio device management
    ];
  };

  home-manager = {
    users = {
      ashpex = {
        # Start Noctalia Shell via systemd (spawn-at-startup lacks PATH in systemd sessions)
        systemd = {
          user = {
            services = {
              noctalia-shell = {
                Unit = {
                  Description = "Noctalia Shell";
                  After = [ "graphical-session.target" ];
                  PartOf = [ "graphical-session.target" ];
                };
                Service = {
                  ExecStart = "${pkgs.unstable.noctalia-shell}/bin/noctalia-shell";
                  Restart = "on-failure";
                  RestartSec = 2;
                };
                Install = {
                  WantedBy = [ "graphical-session.target" ];
                };
              };
            };
          };
        };

        # GTK theme
        home = {
          pointerCursor = {
            name = "Bibata-Modern-Classic";
            package = pkgs.bibata-cursors;
            size = 24;
            gtk = {
              enable = true;
            };
          };
        };
        gtk = {
          enable = true;
          theme = {
            name = "Colloid-Green-Dark-Catppuccin";
            package = pkgs.colloid-gtk-theme.override {
              colorVariants = [ "dark" ];
              themeVariants = [ "green" ];
              tweaks = [ "catppuccin" ];
            };
          };
          iconTheme = {
            name = "Papirus-Dark";
            package = pkgs.papirus-icon-theme;
          };
        };
      };
    };
  };

}
