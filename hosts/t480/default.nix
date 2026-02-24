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

  # Filesystems are managed by Disko (see configuration.nix)

  # ThinkPad-specific packages
  users.users.ashpex.packages = with pkgs; [
    claude-code
    mpv       # Video player
    vscode    # Code editor
    # Example: using unstable packages
    # unstable.some-package
  ];
}
