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
    fd
    alacritty
    php
    pkgs.gnumake
    pkgs.pkg-config
    tree-sitter
    gimp
    libreoffice
    puredata
    helvum
    milkytracker
    tmux
  ];

  # Git config
  programs.git.userName = "trasha";
  programs.git.userEmail = "sasha.friis@icloud.com";
}
