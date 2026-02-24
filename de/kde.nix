# KDE Plasma desktop environment configuration
{ config, pkgs, ... }:

{
  services = {
    # Enable X11 windowing system
    xserver = {
      enable = true;
      # Configure keymap
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    # Enable KDE Plasma Desktop Environment
    displayManager = {
      sddm = {
        enable = true;
      };
    };
    desktopManager = {
      plasma6 = {
        enable = true;
      };
    };

    # Enable sound with pipewire
    pulseaudio = {
      enable = false;
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

    # Enable touchpad support
    libinput = {
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
