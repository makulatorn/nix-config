{ pkgs, ... }:

{
  home.username = "trasha";
  home.homeDirectory = "/home/trasha";

  home.stateVersion = "25.05"; # match system version

  # Programs fi enable
  programs.zsh.enable = true;
  programs.git.enable = true;
  programs.neovim.enable = true;
  programs.btop.enable = true;
  programs.fzf.enable = true;
  programs.lazygit.enable = true;

  # User packages (moved from system to here)
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
    uwufetch
  ];

  # Git config example
  programs.git.userName = "trasha";
  programs.git.userEmail = "sasha.friis@icloud.com";
}
