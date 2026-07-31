{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./sway.nix
    ./dev-packages.nix
  ];

  home.file = {
    ".config/qtile/config.py" = {
      source = ./dotfiles/qtile/config.py;
      force = true;
    };
    ".config/qtile/autostart.sh" = {
      source = ./dotfiles/qtile/autostart.sh;
      force = true;
    };

    ".config/kitty" = {
      source = ./dotfiles/kitty;
      recursive = true;
      force = true;
    };
  };

  home.stateVersion = "26.05";

  home.sessionPath = [ "$HOME/.npm-global/bin" ];

  programs.zsh.enable = true;

  programs.fish = {
    enable = true;

    shellInit = ''
      set -gx PATH $HOME/.npm/bin $PATH
      set -gx PATH $HOME/.emacs.d/bin $PATH
      set -gx PATH $HOME/.guix-profile/bin $PATH
      set -gx GUIX_LOCPATH $HOME/.guix-profile/lib/locale
      set -gx _PR_SHELL fish
      pay-respects fish --alias | source
    '';

    functions = {
      fish_greeting = ''
        random choice "Make mommy proud~" "Mommy missed you~" "Mommys little pet is back~ <3" "You're doing such a good job baby~" "What do now?" "This jacket is awesome! And it’s tighter than dick skin!" "That woman is unspeakably crass." "Another ear splitting hit from The Jester" "Today is a day in your life <3"
      '';
    };

    shellAliases = {
      nixbuild = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
      nixupdate = "sudo nix flake update";
      suicide = "sudo shutdown now";
      docker = "sudo docker";
      dgitconf = "docker exec -u 0 easyrf git config --global --add safe.directory /app";
      precom = "docker exec -u 0 -it easyrf pre-commit run";
      dkill = "sudo docker rm --force";
      dmurder = "docker stop $(docker ps -a -q)";
      doomconf = "cd /home/trasha/.config/doom";
      doomfresh = "pkill -9 emacs; rm -rf ~/.emacs.d/.local; ~/.emacs.d/bin/doom sync";
      doomurder = "pkill -9 emacs && doom sync";
      easypodup = "podman start oracle-free && podman compose -f docker-compose.local.yaml up";
      easypodown = "podman compose -f docker-compose.local.yaml down && podman stop oracle-free";
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "sasha";
        email = "sasha.friis@icloud.com";
      };

      "url \"git@gitlab.com:trasha/\"" = {
        pushInsteadOf = "git@github.com:makulatorn/";
      };

      alias = {
        lgg = "log --oneline --graph";
        lga = "log --all";
        lgn = "log -n";
        whoops = "commit --amend";
        fuck = "commit --amend --no-edit";
        FUCK = "commit --amend -a";
        pushf = "push --force-with-lease";
      };
    };
  };

  programs.emacs = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.btop.enable = true;
  programs.lazygit.enable = true;

  services.flameshot = {
    enable = true;
    settings = {
      General = {
        useGrimAdapter = true;
        showDesktopNotification = true;
      };
    };
  };

  home.packages = with pkgs; [
    mixxx
    grim
    flameshot
    navi
    yazi
    superfile
    kitty
    gimp
    libreoffice
    puredata
    crosspipe
    milkytracker
    wordnet
    reaper
    gnupg
    pinentry-curses
    pass
    aspell
    aspellDicts.en
    autotiling
    wev
    glab
  ];
}
