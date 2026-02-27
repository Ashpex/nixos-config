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

  };

  # Useful packages for Hyprland
  environment = {
    systemPackages = with pkgs; [
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
      hyprpolkitagent # Polkit authentication agent
      hypridle        # Idle daemon
      imv             # Image viewer
      xarchiver       # Archive manager
      blueman         # Bluetooth GUI
      wlogout         # Power menu
    ];
  };

  # Waybar (config managed in dotfiles)
  home-manager.users.ashpex.programs.waybar.enable = true;

  # GTK theme for Hyprland
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

}
