# Waybar configuration for Desktop
# Config and style are managed in dotfiles (see users/ashpex/dotfiles.nix)
{ config, pkgs, ... }:

{
  home-manager.users.ashpex.programs.waybar = {
    enable = true;
  };
}
