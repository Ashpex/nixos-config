# Niri compositor with Noctalia Shell
{ config, pkgs, ... }:

{
  programs = {
    niri = {
      enable = true;
      package = pkgs.unstable.niri;
    };
    uwsm.enable = true;
  };

  services = {
    # Display manager for Niri
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd \"uwsm start -- niri\"";
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

  # Required by Noctalia for wifi, bluetooth, power-profile, and battery features
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  environment = {
    systemPackages = with pkgs; [
      unstable.noctalia-shell    # Desktop shell (Quickshell-based)
      wl-clipboard               # Clipboard
      brightnessctl              # Brightness control
      playerctl                  # Media player control
      pavucontrol                # Audio control GUI
      networkmanagerapplet       # Network tray icon
      blueman                    # Bluetooth GUI
    ];
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      config.common.default = "*";
    };
  };

  # GTK theme for Niri
  home-manager.users.ashpex = {
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
