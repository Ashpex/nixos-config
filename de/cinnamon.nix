# Cinnamon desktop environment configuration
{ config, pkgs, ... }:

{
  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
      desktopManager = {
        cinnamon = {
          enable = true;
        };
      };
    };

    libinput = {
      enable = true;
    };
  };

}
