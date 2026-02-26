# Configuration for ThinkPad T480
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
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

  # Filesystem declarations (for already-installed system)
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/343add33-6f4c-4688-b956-77391d2939e6";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/A5D8-42E9";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  swapDevices = [ ];

  # ThinkPad power management
  services.tlp = {
    enable = true;
    settings = {
      # Internal battery
      START_CHARGE_THRESH_BAT0 = 60;
      STOP_CHARGE_THRESH_BAT0 = 80;
      # Removable battery
      START_CHARGE_THRESH_BAT1 = 60;
      STOP_CHARGE_THRESH_BAT1 = 80;
    };
  };

  # Disable power-profiles-daemon (conflicts with TLP)
  services.power-profiles-daemon.enable = false;

  # ThinkPad-specific packages (empty - using base user packages)
  # users.users.ashpex.packages = with pkgs; [ ];
}
