# Hyprland environment configuration
{ config, pkgs, ... }:

{
  # Enable Hyprland (using unstable for 0.53.3+)
  programs = {
    hyprland = {
      enable = true;
      package = pkgs.unstable.hyprland;
      withUWSM = true;
      xwayland = {
        enable = true;
      };
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

    # Enable sound with pipewire
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse = {
        enable = true;
      };
    };
  };

  # Useful packages for Hyprland
  environment = {
    systemPackages = with pkgs; [
      unstable.noctalia-shell # Desktop shell (Quickshell-based)
      waybar          # Status bar
      mako            # Notification daemon
      hyprlock        # Lock screen
      pcmanfm         # File manager
      rofi            # App launcher (rofi-wayland merged into rofi)
      swww            # Wallpaper
      grim            # Screenshots
      slurp           # Screen area selection
      wl-clipboard    # Clipboard
      brightnessctl   # Brightness control
      playerctl       # Media player control
      pavucontrol     # Audio control GUI
      networkmanagerapplet # Network tray icon
      xdg-desktop-portal-hyprland # Screen sharing & file dialogs
      hyprpolkitagent # Polkit authentication agent
      hypridle        # Idle daemon
      imv             # Image viewer
      xarchiver       # Archive manager
      blueman         # Bluetooth GUI
      wlogout         # Power menu
    ];
  };

  # XDG portal for screen sharing (automatically configured by programs.hyprland)
  xdg = {
    portal = {
      enable = true;
    };
  };

  # Waybar (config managed in dotfiles)
  home-manager.users.ashpex.programs.waybar.enable = true;

  # GTK theme for Hyprland
  home-manager.users.ashpex = {
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

    home.pointerCursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
      gtk.enable = true;
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

  # Fonts
  fonts = {
    packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.symbols-only
      font-awesome
      noto-fonts
      noto-fonts-cjk-sans
    ];
  };
}
