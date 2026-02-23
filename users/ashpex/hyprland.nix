# HyprPanel configuration for Hyprland
# Import this in your host's default.nix when using Hyprland
{ config, pkgs, ... }:

{
  home-manager.users.ashpex = {
    # HyprPanel - programs.hyprpanel option doesn't exist in nixpkgs 25.11
    # TODO: Install hyprpanel manually or from unstable once home-manager works
  };
}
