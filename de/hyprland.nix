# Hyprland environment configuration
#
# Note: HyprPanel configuration is in users/ashpex/hyprland.nix
# Import it in your host's flake.nix when using Hyprland
{ config, pkgs, ... }:

{
  # Enable Hyprland (using unstable for 0.53.3+)
  programs = {
    hyprland = {
      enable = true;
      package = pkgs.unstable.hyprland;
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
          command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd Hyprland";
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
      # HyprPanel is configured in home-manager (see users/ashpex/hyprland.nix)
      pcmanfm         # File manager
      rofi            # App launcher (rofi-wayland merged into rofi)
      swww            # Wallpaper
      grim            # Screenshots
      slurp           # Screen area selection
      wl-clipboard    # Clipboard
      brightnessctl   # Brightness control
      playerctl       # Media player control
    ];
  };

  # XDG portal for screen sharing (automatically configured by programs.hyprland)
  xdg = {
    portal = {
      enable = true;
    };
  };

  # Fonts
  fonts = {
    packages = with pkgs; [
      nerd-fonts.fira-code
    ];
  };
}
