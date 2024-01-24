{
  pkgs,
  lib,
  ...
}: let
  username = "snake";
in {
  users.users.snake = {
    isNormalUser = true;
    description = "snake";
    extraGroups = ["networkmanager" "wheel"];
  };
  
  nix.settings = {
    # enable flakes globally
    experimental-features = ["nix-command" "flakes"];

  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };


  environment.systemPackages = with pkgs; [
     vlc
     partition-manager
     mediawriter
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     pciutils #better than busybox version of lspci - need to see if I can have both
     wget
     git
     librewolf
     chromium
     tmux

     pandoc
     texliveTeTeX

     keepassxc
     kate
     firefox
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Overpass" "MPlus" ]; })
  ];

}
