# HyprPanel configuration for Hyprland
# Import this in your host's default.nix when using Hyprland
{ config, pkgs, ... }:

{
  home-manager.users.ashpex = {
    # HyprPanel - programs.hyprpanel doesn't exist in nixpkgs 25.11
    # Install manually instead (see desktop/hyprland.nix)
    # We'll add it to system packages once home-manager works

    # Placeholder config - will add HyprPanel later
    home.packages = [ ];
  };
}
