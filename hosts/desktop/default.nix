# Configuration for Desktop
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./disko.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  networking.hostName = "desktop";

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "usbhid" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
