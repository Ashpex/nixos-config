# KDE Plasma desktop environment configuration
{ config, pkgs, ... }:

{
  # Enable X11 windowing system
  services.xserver.enable = true;

  # Enable KDE Plasma Desktop Environment
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable sound with pipewire
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support
  services.libinput.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];
}
