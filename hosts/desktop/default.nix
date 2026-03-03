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
  boot.kernelModules = [ "kvm-intel" "i2c-dev" ];  # i2c-dev for DDC/CI monitor brightness control
  boot.extraModulePackages = [ ];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # DDC/CI support for external monitor brightness control
  hardware.i2c.enable = true;

  # Allow users in video group to access i2c devices
  services.udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", GROUP="video", MODE="0660"
  '';
}
