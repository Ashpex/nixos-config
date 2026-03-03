# GUI configuration shared across graphical hosts
{ config, pkgs, ... }:

{
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      kitty
    ];
  };

  programs = {
    firefox = {
      enable = true;
      policies = {
        DisableTelemetry = true;
        DisablePocket = true;
      };
    };
  };

  services = {
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
    printing = {
      enable = true;
    };
  };

  fonts = {
    packages = with pkgs; [
      fira
      nerd-fonts.jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
    ];
  };

  security = {
    polkit = {
      enable = true;
    };
    rtkit = {
      enable = true;
    };
  };

  home-manager.users.ashpex = {
    home.pointerCursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
      gtk.enable = true;
    };
    gtk = {
      enable = true;
      font = {
        name = "Fira Sans";
        size = 11;
      };
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
