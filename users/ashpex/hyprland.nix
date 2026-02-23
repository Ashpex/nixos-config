# HyprPanel configuration for Hyprland
# Import this in your host's default.nix when using Hyprland
{ config, pkgs, ... }:

{
  home-manager.users.ashpex = {
    # Empty for now - we'll add HyprPanel later once home-manager works
    home.packages = [ ];
  };
}
