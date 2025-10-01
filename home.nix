{ pkgs, username, homeDirectory, ... }:

{
  home.username = username;
  home.homeDirectory = homeDirectory;
  home.stateVersion = "25.05";

  programs.zsh.enable = true;
  programs.git.enable = true;
  programs.neovim.enable = true;
  programs.btop.enable = true;
  programs.fzf.enable = true;
  programs.lazygit.enable = true;

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
    rofi
    alacritty
    php
  ];

  programs.git.userName = "trasha";
  programs.git.userEmail = "sasha.friis@icloud.com";
}
