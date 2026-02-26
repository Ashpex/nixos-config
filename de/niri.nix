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
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd niri-session";
          user = "greeter";
        };
      };
    };

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

    # Required by Noctalia
    power-profiles-daemon = {
      enable = true;
    };
    upower = {
      enable = true;
    };
  };

  # Required by Noctalia
  networking = {
    networkmanager = {
      enable = true;
    };
  };

  hardware = {
    bluetooth = {
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

  # GTK theme
  home-manager = {
    users = {
      ashpex = {
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
