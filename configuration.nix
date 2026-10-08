{
  config,
  pkgs,
  lib,
  ...
}:

{
  environment = {
    # --- SESSION PATH ---
    sessionVariables = {
      PATH = "$HOME/.nix-profile/bin:/run/current-system/sw/bin:$PATH";
      WLR_DRM_DEVICES = "/dev/dri/card1";
    };

    # All of this is to make sure all the libraries needed for GEM
    # to work in pure data on Nixos are in the correct path
    # alongside pipewire.jack which also uses enviroment.variables
    variables.LD_LIBRARY_PATH = lib.mkForce (
      lib.makeLibraryPath (
        with pkgs;
        [
          pipewire.jack
          stdenv.cc.cc.lib
          fribidi
          ftgl
          libglvnd
          libGLU
          glfw
        ]
      )
    );

    # --- SYS PKGS ---
    systemPackages = with pkgs; [
      udiskie
      wget
      nitch
      pay-respects
      pavucontrol
      networkmanagerapplet
      pkgs.thunar
      pkgs.xfce4-power-manager
      pkgs.xfce4-notifyd
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
      cataclysm-dda

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
      wlr-randr
      wdisplays
      reaper
      imagemagick
      fzf
      feh
      nh
    ];
  };

  # --- IMPORTS ---
  imports = [ ./hardware-configuration.nix ];

  nix = {

    # --- NIX SETTINGS ---
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    settings.trusted-users = [
      "root"
      "trasha"
    ];

    # --- CLEANING ---
    gc.automatic = false;
  };

  boot = {
    # --- BOOTLOADER ---
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    initrd.availableKernelModules = [
      "rtsx_pci_sdmmc"
      "rtsx_pci"
    ];

    kernelModules = [
      "rtsx_pci_sdmmc"
      "evdi"
    ];

    kernelParams = [
      "pcie_aspm=off"
      "rtsx_pci.aspm_enabled=0"
    ];

  };

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

  programs = {
    nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep 3 --keep-since 3d";
      };
    };
    nm-applet.enable = true;

    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      package = pkgs.swayfx;
    };

    # --- PROGRAMS ---
    firefox.enable = true;
    nix-ld.enable = true;
    nix-ld.libraries = with pkgs; [
      stdenv.cc.cc.lib
    ];

    gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-curses;
    };

    steam = {
      enable = true;
    };

    gamemode.enable = true;

    command-not-found.enable = true;
  };

  console = {
    useXkbConfig = true;
  };

  services = {
    # --- WAYLAND/X11 --
    xserver = {
      enable = true;
      xkb = {
        layout = "us,dk,us";
        options = "ctrl:swapcaps";
        variant = "altgr-intl,,colemak_dh";
      }; # third variant = colemak_dh on us base
    };

    displayManager.sddm = {
      enable = true;
      wayland.enable = false;
    };

    xserver.videoDrivers = [
      "modesetting"
    ];

    # --- PRINT/SOUND ---
    printing.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    blueman.enable = true;

    udisks2.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;

    # --- OpenSSH ---
    openssh = {
      enable = true;
      ports = [ 2222 ];
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };

    # --- PICOM ---
    picom = {
      enable = true;
      activeOpacity = 0.95;
      inactiveOpacity = 0.7;
      vSync = true;
      backend = "glx";
      shadow = true;
      fade = true;
      fadeDelta = 5;
      opacityRules = [ "100:class_g = 'firefox' " ];
    };

    guix.enable = true;

    udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", ENV{DEVTYPE}=="usb_interface", RUN+="${pkgs.bash}/bin/sh -c 'echo -n %k > /sys/bus/usb/drivers/ftdi_sio/unbind'"
      SUBSYSTEM=="usb", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", MODE="0666", GROUP="dialout"
    '';
  };
  #services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  hardware.bluetooth.enable = true;

  # --- USERS ---
  users.users.trasha = {
    isNormalUser = true;
    description = "trasha";
    extraGroups = [
      "networkmanager"
      "wheel"
      "storage"
      "docker"
      "video"
      "input"
      "dialout"
    ];
  };

  virtualisation.docker = {
    enable = true;
    package = pkgs.docker_29;
    rootless = {
      enable = false;
    };
  };

  virtualisation.podman = {
    enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  # --- ALLOW UNFREE PKGS ---
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [ "dotnet-runtime-7.0.20" ];

  # --- FONTS ---
  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.symbols-only
    ];
  };

  networking = {
    # --- NETWORK ---
    hostName = "nixos";
    networkmanager.enable = true;

    # --- FIREWALL ---
    firewall.allowedTCPPorts = [
      8080
      1521
    ];
    firewall.trustedInterfaces = [ "podman0" ];
  };
  # --- STATE VERSION ---
  system.stateVersion = "25.11";
}
