{ config, pkgs, lib, ... }:

{
  # --- SESSION PATH ---
  environment.sessionVariables = {
    PATH = "$HOME/.nix-profile/bin:/run/current-system/sw/bin:$PATH";
  };

  # --- IMPORTS ---
  imports = [ ./hardware-configuration.nix ];

  # --- NIX SETTINGS ---
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.trusted-users = [ "root" "trasha" ];

  # --- BOOTLOADER ---
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # --- NETWORK ---
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;

  # --- TIME LOCALE ---
  time.timeZone = "Europe/Copenhagen";
  i18n.defaultLocale = "en_DK.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "da_DK.UTF-8";
    LC_IDENTIFICATION = "da_DK.UTF-8";
    LC_MEASUREMENT = "da_DK.UTF-8";
    LC_MONETARY = "da_DK.UTF-8";
    LC_NAME = "da_DK.UTF-8";
    LC_NUMERIC = "da_DK.UTF-8";
    LC_PAPER = "da_DK.UTF-8";
    LC_TELEPHONE = "da_DK.UTF-8";
    LC_TIME = "da_DK.UTF-8";
  };

  # --- WAYLAND/X11 --
  services.xserver = {
    enable = true;
    xkb.layout = "us,dk,us";
    xkb.options = "ctrl:swapcaps";
    xkb.variant =
      "altgr-intl,,colemak_dh"; # third variant = colemak_dh on us base
  };
  console = { useXkbConfig = true; };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = false;
  };

  services.xserver.windowManager.qtile.enable = true;
  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];
  boot = {
    initrd.availableKernelModules = [ "rtsx_pci_sdmmc" "rtsx_pci" ];

    kernelModules = [ "rtsx_pci_sdmmc" "evdi" ];

    kernelParams = [ "pcie_aspm=off" "rtsx_pci.aspm_enabled=0" ];
  };

  # --- PRINT/SOUND ---
  services.printing.enable = true;
  #services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # --- USERS ---
  users.users.trasha = {
    isNormalUser = true;
    description = "trasha";
    extraGroups = [ "networkmanager" "wheel" "storage" "docker" ];
  };

  environment.variables = { QT_STYLE_OVERRIDE = "adwaita-dark"; };

  services.udisks2.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  # --- PROGRAMS ---
  programs.firefox.enable = true;

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  virtualisation.docker = {
    enable = true;
    package = pkgs.docker_29;
    rootless = { enable = false; };
  };

  virtualisation.podman = {
    enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  programs.steam = { enable = true; };

  programs.gamemode.enable = true;

  # --- ALLOW UNFREE PKGS ---
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [ "dotnet-runtime-7.0.20" ];

  programs.command-not-found.enable = true;

  # --- SYS PKGS ---
  environment.systemPackages = with pkgs; [
    udiskie
    wget
    adwaita-qt
    rofi
    nitch
    pay-respects
    pavucontrol
    networkmanagerapplet
    xfce.thunar
    xfce.xfce4-power-manager
    xfce.xfce4-notifyd
    ripgrep
    xclip
    unzip
    tmux
    pkgs.gnumake
    pkgs.pkg-config
    vintagestory
    google-chrome
    microsoft-edge
    transmission_4-gtk
    vlc
    sqlite

    # DEV
    podman-compose
    git
    redis
    postgresql
    pango
    cairo
    glibc
    file
    direnv
    dbeaver-bin
    quickemu
    quickgui

    # TOOLS
    arandr
    reaper
    displaylink
    imagemagick
    fzf
  ];

  # --- FONTS ---
  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [ nerd-fonts.fira-code nerd-fonts.symbols-only ];
  };

  # --- OpenSSH ---
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "no";
  services.openssh.settings.PasswordAuthentication = false;
  services.openssh.ports = [ 2222 ];

  # --- FIREWALL ---
  networking.firewall.allowedTCPPorts = [ 8080 1521 ];
  networking.firewall.trustedInterfaces = [ "podman0" ];
  # --- STATE VERSION ---
  system.stateVersion = "25.11";

  # --- PICOM ---
  services.picom = {
    enable = true;
    package = pkgs.picom;
  };

  services.guix.enable = true;
}
