{ pkgs, ... }:

{
  home.stateVersion = "25.05";

  programs.zsh.enable = true;

  programs.fish = {
    enable = true;

    shellInit = ''
      thefuck --alias | source
    '';

    functions = {
      fish_greeting = ''
        random choice "Make mommy proud~" "Mommy missed you~" "Mommys little pet is back~ <3"
      '';
    };

    shellAliases = {
      nixbuild = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
      nixupdate = "sudo nix flake update";
      suicide = "sudo shutdown now";
    };
  };

  programs.git = {
    enable = true;
    userName = "sasha";
    userEmail = "sasha.friis@icloud.com";
  };

  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.helm
    ];
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
