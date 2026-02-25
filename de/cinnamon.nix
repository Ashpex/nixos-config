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

    libinput = {
      enable = true;
    };
  };

  # GTK theme for Cinnamon
  home-manager.users.ashpex = {
    gtk = {
      enable = true;
      theme = {
        name = "Mint-Y-Dark";
        package = pkgs.mint-themes;
      };
      iconTheme = {
        name = "Mint-Y-Dark";
        package = pkgs.mint-y-icons;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    mint-themes
    mint-y-icons
  ];

  fonts = {
    packages = with pkgs; [
      nerd-fonts.fira-code
    ];
  };
}
