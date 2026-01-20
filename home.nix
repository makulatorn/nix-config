{ pkgs, ... }:

{
  home.stateVersion = "25.05";

  programs.zsh.enable = true;

  home.sessionPath = [ "$HOME/.npm-global/bin" ];

  home.sessionVariables = {
    DOOMDIR = "/home/trasha/.config/doom";
    DOOMLOCALDIR = "/home/trasha/.emacs.d/.local";
  };

  programs.fish = {
    enable = true;

    shellInit = ''
      thefuck --alias | source
    '';

    functions = {
      fish_greeting = ''
        random choice "Make mommy proud~" "Mommy missed you~" "Mommys little pet is back~ <3" "You're doing such a good job baby~"
      '';
    };

    shellAliases = {
      nixbuild = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
      nixupdate = "sudo nix flake update";
      suicide = "sudo shutdown now";
      docker = "sudo docker";
      doomconf = "cd /home/trasha/.config/doom";
      doomfresh =
        "pkill -9 emacs; rm -rf ~/.emacs.d/.local; ~/.emacs.d/bin/doom sync";
    };
  };

  programs.git = {
    enable = true;
    userName = "sasha";
    userEmail = "sasha.friis@icloud.com";
  };

  programs.neovim = { enable = true; };

  programs.btop.enable = true;
  programs.lazygit.enable = true;

  home.packages = with pkgs; [
    (tree-sitter.withPlugins (p: [
      p.tree-sitter-typescript
      p.tree-sitter-tsx
      p.tree-sitter-html
      p.tree-sitter-javascript
    ]))
    kitty
    gimp
    libreoffice
    puredata
    helvum
    milkytracker
  ];
}
