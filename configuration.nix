{ config, pkgs, lib, ... }:

{
  # --- Session PATH ---
  environment.sessionVariables = {
    PATH = "$HOME/.nix-profile/bin:/run/current-system/sw/bin:$PATH";
  };

  # --- Imports ---
  imports = [ ./hardware-configuration.nix ];

  # --- Nix settings ---
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.trusted-users = [ "root" "trasha" ];

  # --- Bootloader ---
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # --- Networking ---
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;

  # --- Time & Locale ---
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

  # --- Wayland ---
  # --- Disable X11 ---
  # Find this section and update it
  services.xserver = {
    enable = true;
    xkb.layout = "dk";
  };
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = false;
  };
  services.xserver.windowManager.qtile.enable = true;
  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];
  boot.kernelModules = [ "evdi" ];

  # --- Console ---
  console.keyMap = "dk-latin1";

  # --- Printing & Sound ---
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

  # --- Users ---
  users.users.trasha = {
    isNormalUser = true;
    description = "trasha";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  environment.variables = { QT_STYLE_OVERRIDE = "adwaita-dark"; };

  # --- Programs ---
  programs.firefox.enable = true;

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  virtualisation.docker.enable = true;

  programs.steam = { enable = true; };

  programs.gamemode.enable = true;

  # --- Allow unfree packages ---
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [ "dotnet-runtime-7.0.20" ];

  programs.command-not-found.enable = true;

  # --- System packages ---
  environment.systemPackages = with pkgs; [
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
    transmission_4-gtk
    vlc
    sqlite

    # dev
    podman
    podman-compose
    git
    docker
    redis
    postgresql
    pango
    cairo
    glibc
    file
    direnv

    # tools
    arandr
    reaper
    displaylink
  ];

  # --- Fonts ---
  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.symbols-only # Recommended for icons
    ];
  };

  # --- OpenSSH ---
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "no";
  services.openssh.settings.PasswordAuthentication = false;
  services.openssh.ports = [ 2222 ];

  # --- Firewall ---
  networking.firewall.allowedTCPPorts = [ 2222 ];

  # --- State version ---
  system.stateVersion = "25.11";

  # --- Picom (still enabled if needed) ---
  services.picom = {
    enable = true;
    package = pkgs.picom;
  };
}
