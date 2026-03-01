{ config, pkgs, ... }:

{
  imports = [
      ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-btw";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Jakarta";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "id_ID.UTF-8";
    LC_IDENTIFICATION = "id_ID.UTF-8";
    LC_MEASUREMENT = "id_ID.UTF-8";
    LC_MONETARY = "id_ID.UTF-8";
    LC_NAME = "id_ID.UTF-8";
    LC_NUMERIC = "id_ID.UTF-8";
    LC_PAPER = "id_ID.UTF-8";
    LC_TELEPHONE = "id_ID.UTF-8";
    LC_TIME = "id_ID.UTF-8";
  };

  services.xserver.enable = true;

  ## NVIDIA
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics.enable = true;

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = false;
    nvidiaSettings = true;

    prime = {
      offload.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  ## Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  ## Power
  services.power-profiles-daemon.enable = true;

  ## Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  ## Hyprland
  programs.hyprland.enable = true;

  ## Display manager
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "Hyprland";
      user = "kuzan";
    };
  };

  ## Keyboard
  services.xserver.xkb.layout = "us";

  ## User
  users.users.kuzan = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "video" ];
    packages = with pkgs; [
		tree
	];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
		pciutils
		git
		vim
  ];

  fonts.packages = with pkgs; [
     nerd-fonts.jetbrains-mono
     noto-fonts
     roboto
     inter
  ];

  security.sudo.wheelNeedsPassword = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.11";

}
