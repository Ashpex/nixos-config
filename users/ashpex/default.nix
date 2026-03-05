{ pkgs, ... }:

{
  users.users.ashpex = {
    isNormalUser = true;
    description = "Ashpex";
    extraGroups = [
      "audio" # Audio devices
      "docker" # Docker access
      "input" # Input devices (gaming peripherals, etc.)
      "networkmanager"
      "video" # GPU/video acceleration
      "wheel" # Sudo access
    ];
    shell = pkgs.zsh;
    initialPassword = "changeme"; # Change with `passwd` after first login
    packages = with pkgs; [
      brave
      claude-code
      vscode-fhs
      deadnix # Nix dead code finder (used by nvim)
      discord
      feishin # Music streaming client
      go
      jq
      keepassxc
      megasync
      nil # Nix LSP
      nixpkgs-fmt # Nix formatter (used by nil)
      obsidian
      rustup # Rust toolchain installer
      thunderbird-bin
      yazi # Terminal file manager
      yq
      gcc
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
        fcitx5.waylandFrontend = true;
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

      programs.gh = {
        enable = true;
        gitCredentialHelper.enable = true; # Use gh as git credential helper
        settings = {
          git_protocol = "https";
        };
      };

      programs.mpv.enable = true;
    };
  };
}
