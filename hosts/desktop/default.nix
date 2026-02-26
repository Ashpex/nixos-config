# Configuration for Desktop
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./disko.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  networking.hostName = "desktop";

  # TODO: Set kernel packages
  # boot.kernelPackages = pkgs.linuxPackages_latest;

  # TODO: Hardware-specific settings (run nixos-generate-config and copy relevant bits)
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "usbhid" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  # Desktop-specific packages (empty - using base user packages)
  # users.users.ashpex.packages = with pkgs; [ ];
}
