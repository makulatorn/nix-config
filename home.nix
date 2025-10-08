{ pkgs, ... }:
# update:
# sudo nix flake update
# sudo nixos-rebuild switch --flake /etc/nixos#nixos
# Updates both system packages AND Home Manager packages

{
  # Must set this for HM 25.11+
  home.stateVersion = "25.05";

  # Programs
  programs.zsh.enable = true;
  programs.git.enable = true;
  programs.neovim.enable = true;
  programs.btop.enable = true;
  programs.fzf.enable = true;
  programs.lazygit.enable = true;

  # Packages
  home.packages = with pkgs; [
    xclip
    ripgrep
    fd
    unzip
    nodejs
    cargo
    python312Full
    python312Packages.pip
    python312Packages.pynvim
    arandr
    alacritty
    php
    gcc
    pkgs.gnumake
    pkgs.pkg-config
    autoconf
    automake
    libtool
    ninja
    nodePackages.npm
    tree-sitter
    gimp
  ];

  # Git config
  programs.git.userName = "trasha";
  programs.git.userEmail = "sasha.friis@icloud.com";
}
