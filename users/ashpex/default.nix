{ pkgs, ... }:

{
  users.users.ashpex = {
    isNormalUser = true;
    description = "Ashpex";
    extraGroups = [
      "docker"       # For Docker access
      "networkmanager"
      "wheel"        # For sudo
    ];
    shell = pkgs.zsh;
    initialPassword = "changeme"; # Change with `passwd` after first login
    packages = with pkgs; [
      claude-code
      discord
      mpv
      obsidian
      zathura
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.ashpex = {
      home = {
        stateVersion = "25.11";
        username = "ashpex";
        homeDirectory = "/home/ashpex";
        pointerCursor = {
          name = "Bibata-Modern-Classic";
          package = pkgs.bibata-cursors;
          size = 24;
          gtk.enable = true;
        };
      };

      # GTK theme
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

      # Let Home Manager install and manage itself
      programs.home-manager.enable = true;

      # Dotfiles are managed in users/ashpex/dotfiles.nix
      # See README.md "Dotfiles Management" section for details

      i18n.inputMethod = {
        enabled = "fcitx5";
        fcitx5.addons = with pkgs; [
          fcitx5-bamboo
        ];
      };

      programs.git = {
        enable = true;
        settings = {
          user = {
            name = "Ashpex";
            email = "ashpex@pm.me";
          };
        };
      };
    };
  };
}
