{ pkgs, ... }:
let
  # --- Language Runtimes & Managers ---
  languages = with pkgs; [
    python3
    python3Packages.pip
    conda
    pyenv
    pipenv
    poetry
    nodejs
    typescript
    rustc
    cargo
    ghc
    cabal-install
    clojure
    babashka
    leiningen
  ];

  # --- LSP Servers (For Doom Emacs) ---
  lspServers = with pkgs; [
    pyright
    bash-language-server
    typescript-language-server
    haskell-language-server
    yaml-language-server
    nixd
    rust-analyzer
    marksman
    taplo
    emmet-ls
    clojure-lsp
    vscode-langservers-extracted # Includes HTML/CSS/JSON/ESLint
  ];

  # --- Formatters & Linters ---
  lintFormat = with pkgs; [
    python3Packages.black
    python3Packages.isort
    python3Packages.pylint
    python3Packages.mypy
    python3Packages.pyflakes
    python3Packages.pytest
    prettierd
    shellcheck
    shfmt
    dockfmt
    ktlint
    nixfmt-classic
    stylelint
    cljfmt
  ];

  # --- Build Tools & Dev Utilities ---
  devTools = with pkgs; [
    gnumake
    pkg-config
    autoconf
    automake
    libtool
    ninja
    gcc
    cmake
    fd
    ripgrep
    tmux
    git
    ghc
    haskellPackages.hoogle
    python3Packages.django
    python3Packages.requests
    python3Packages.httpx
    python3Packages.uvicorn
    python3Packages.weasyprint
    python3Packages.python-magic
  ];

in {
  home.stateVersion = "25.11";

  home.sessionPath = [ "$HOME/.npm-global/bin" ];

  home.sessionVariables = {
    DOOMDIR = "/home/trasha/.config/doom";
    DOOMLOCALDIR = "/home/trasha/.emacs.d/.local";
  };

  programs.zsh.enable = true;

  programs.fish = {
    enable = true;

    shellInit = ''
      pay-respects fish --alias | source
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
      dkill = "sudo docker rm --force";
      doomconf = "cd /home/trasha/.config/doom";
      doomfresh =
        "pkill -9 emacs; rm -rf ~/.emacs.d/.local; ~/.emacs.d/bin/doom sync";
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "sasha";
        email = "sasha.friis@icloud.com";
      };
      alias = {
        lgg = "log --oneline --graph";
        lga = "log --all";
        lgn = "log -n";
        fuck = "commit --amend --no-edit";
        fuuck = "commit --amend -a";
        pushf = "push --force-with-lease";
      };
    };
  };

  programs.neovim = { enable = true; };

  programs.vscode = {
    enable = true;
    profiles.default = { };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.btop.enable = true;
  programs.lazygit.enable = true;

  home.packages = with pkgs;
    [
      emacs30
      kitty
      gimp
      libreoffice
      puredata
      helvum
      milkytracker
      wordnet
      reaper
      gnupg
      pinentry-curses
      pass
      aspell
      aspellDicts.en
    ] ++ languages ++ lspServers ++ lintFormat ++ devTools;
}
