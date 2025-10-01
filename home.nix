{ pkgs, ... }:

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
  ];

  # Git config
  programs.git.userName = "trasha";
  programs.git.userEmail = "sasha.friis@icloud.com";
}
