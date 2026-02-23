# Configuration for ThinkPad T480
{ config, pkgs, ... }:

{
  imports = [
    # ./hardware-configuration.nix  # Commented out for VM testing
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  # Hostname
  networking.hostName = "nixos";

  # Use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # ThinkPad-specific packages
  users.users.ashpex.packages = with pkgs; [
    kdePackages.kate
    pkgs.claude-code
    # Example: using unstable packages
    # pkgs.unstable.some-package
  ];
}
