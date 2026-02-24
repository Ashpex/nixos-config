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
      # Add your user-specific packages here
      # Example: using unstable packages
      # pkgs.unstable.some-package
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
      };

      # Let Home Manager install and manage itself
      programs.home-manager.enable = true;

      # Dotfiles are managed in users/ashpex/dotfiles.nix
      # See README.md "Dotfiles Management" section for details

      programs.git = {
        enable = true;
        userName = "Ashpex";
      };
    };
  };
}
