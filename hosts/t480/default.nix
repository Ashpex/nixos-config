# Configuration for ThinkPad T480
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./disko.nix
    ./waybar.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  # Hostname
  networking.hostName = "nixos";

  # Use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Hardware-specific settings (from hardware-configuration.nix)
  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  # Intel CPU microcode updates
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Filesystems managed by disko (see configuration.nix)
  swapDevices = [ ];

  # ThinkPad power management
  services.tlp = {
    enable = false;
    settings = {
      # Internal battery
      START_CHARGE_THRESH_BAT0 = 60;
      STOP_CHARGE_THRESH_BAT0 = 80;
      # Removable battery
      START_CHARGE_THRESH_BAT1 = 60;
      STOP_CHARGE_THRESH_BAT1 = 80;
    };
  };

  # ThinkPad-specific packages (empty - using base user packages)
  # users.users.ashpex.packages = with pkgs; [ ];
}
