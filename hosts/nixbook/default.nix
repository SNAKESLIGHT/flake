{ config, pkgs, ... }:

{
  imports =
    [
      ../../modules/system.nix
      ../../modules/kde.nix
      #../../modules/nixvim.nix
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixbook"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;
  networking.enableB43Firmware = true;
  #networking.networkmanager.unmanaged = [
  # "type:wlan"
  #];

  boot.kernelModules = [ "b43" ];
  boot.blacklistedKernelModules = [
    "wl"
  ];

  system.stateVersion = "23.11"; # Did you read the comment?
}
