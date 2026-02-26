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
      gopls           # Go LSP
      mpv
      nil             # Nix LSP
      nixpkgs-fmt     # Nix formatter (used by nil)
      obsidian
      rust-analyzer   # Rust LSP
      zathura
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users.ashpex = {
      home = {
        stateVersion = "25.11";
        username = "ashpex";
        homeDirectory = "/home/ashpex";
      };

      # Let Home Manager install and manage itself
      programs.home-manager.enable = true;

      # Dotfiles are managed in users/ashpex/dotfiles.nix
      # See README.md "Dotfiles Management" section for details

      i18n.inputMethod = {
        enable = true;
        type = "fcitx5";
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
