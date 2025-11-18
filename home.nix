{ pkgs, ... }:

{
  home.stateVersion = "25.05";

  programs.zsh.enable = true;
  programs.fish.enable = true;

  programs.git = {
    enable = true;
    userName = "trasha";
    userEmail = "sasha.friis@icloud.com";
  };

  programs.btop.enable = true;
  programs.lazygit.enable = true;

  home.packages = with pkgs; [
    kitty
    gimp
    libreoffice
    puredata
    helvum
    milkytracker
  ];
}
