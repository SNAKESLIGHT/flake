{pkgs, config, lib, ...}:
{
services.xserver.enable = true;
services.xserver.displayManager.sddm.enable = true;
services.xserver.desktopManager.plasma5.enable = true;

services.xserver.displayManager.defaultSession = "plasmawayland";

#environment.plasma5.excludePackages = with pkgs.libsForQt5; [
#    konsole
#];
}
