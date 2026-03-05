# Hyprland environment configuration
{ config, pkgs, ... }:

{
  # Enable Hyprland (using unstable for 0.53.3+)
  programs = {
    hyprland = {
      enable = true;
      package = pkgs.unstable.hyprland;
      withUWSM = true;
    };
  };

  services = {
    # Display manager for Hyprland
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd start-hyprland";
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

  # Useful packages for Hyprland
  environment = {
    systemPackages = with pkgs; [
      unstable.noctalia-shell    # Desktop shell (Quickshell-based)
      pcmanfm         # File manager
      wl-clipboard    # Clipboard
      brightnessctl   # Brightness control
      playerctl       # Media player control
      pavucontrol     # Audio control GUI
      networkmanagerapplet # Network tray icon
      hyprpolkitagent # Polkit authentication agent
      imv             # Image viewer
      xarchiver       # Archive manager
      wf-recorder     # Screen recorder for Wayland
      ddcutil         # DDC/CI monitor control for external displays
    ];
  };

  # XDG Portal configuration
  xdg = {
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-hyprland ];
      config = {
        common = {
          default = [ "gtk" ];
        };
        hyprland = {
          default = [ "hyprland" "gtk" ];
        };
      };
    };
  };

  home-manager = {
    users = {
      ashpex = {
        # Start Noctalia Shell via systemd
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
                  Environment = "QS_ICON_THEME=Papirus-Dark";
                };
                Install = {
                  WantedBy = [ "graphical-session.target" ];
                };
              };
            };
          };
        };
      };
    };
  };

}
