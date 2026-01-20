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
    thefuck
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
    transmission_3-gtk
    vlc

    # dev
    python312Full
    python312Packages.pip
    python312Packages.django
    python312Packages.requests
    python312Packages.httpx
    python312Packages.uvicorn
    python312Packages.black
    python312Packages.isort
    python312Packages.pylint
    python312Packages.mypy
    python312Packages.weasyprint
    python312Packages.python_magic
    pipenv
    python312Packages.pyflakes
    python312Packages.pytest
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
    rustc
    cargo
    ghc
    cabal-install
    fd
    direnv
    clojure
    typescript
    conda
    pyenv

    # tools
    arandr
    autoconf
    automake
    libtool
    ninja
    gcc
    reaper
    emacs30
    zip
    cmake
    poetry
    displaylink
    nodePackages.npm
    nodejs
    gnupg
    pinentry-curses
    pass
    babashka
    leiningen

    # LSP servers
    pyright
    bash-language-server
    typescript-language-server
    haskell-language-server
    yaml-language-server
    nixd
    rust-analyzer
    marksman # markdown lsp
    taplo
    emmet-ls
    haskellPackages.hoogle
    clojure-lsp

    # formatters/linters
    prettierd
    shellcheck
    shfmt
    nodePackages.prettier
    dockfmt
    ktlint
    nixfmt-classic
    stylelint
    cljfmt

    #spellcheckers
    vscode-langservers-extracted
    aspell
    aspellDicts.en
  ];

  # --- Fonts ---
  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [ (nerdfonts.override { fonts = [ "FiraCode" ]; }) ];
  };

  # --- OpenSSH ---
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "no";
  services.openssh.settings.PasswordAuthentication = false;
  services.openssh.ports = [ 2222 ];

  # --- Firewall ---
  networking.firewall.allowedTCPPorts = [ 2222 ];

  # --- State version ---
  system.stateVersion = "24.11";

  # --- Picom (still enabled if needed) ---
  services.picom = {
    enable = true;
    package = pkgs.picom;
  };
}
