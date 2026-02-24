# Configuration for Desktop
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  networking.hostName = "desktop";

  # TODO: Set kernel packages
  # boot.kernelPackages = pkgs.linuxPackages_latest;

  # TODO: Hardware-specific settings (run nixos-generate-config and copy relevant bits)
  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  # Desktop-specific packages
  users.users.ashpex.packages = with pkgs; [
    claude-code
    mpv
    vscode
  ];
}
