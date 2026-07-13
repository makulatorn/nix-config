{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # --- LANG RUNTIME/MANAGERS ---
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
    sbcl
    jq
    pandoc
    tidy-viewer

    # --- LSP ---
    basedpyright
    ruff
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

    # --- FORMATTERS/LINTERS ---
    python3Packages.mypy
    python3Packages.pytest
    prettierd
    shellcheck
    shfmt
    dockfmt
    ktlint
    nixfmt
    stylelint
    cljfmt

    # --- BUILD TOOLS ---
    pay-respects
    nix-search
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
    haskellPackages.hoogle
    python3Packages.django
    python3Packages.requests
    python3Packages.httpx
    python3Packages.uvicorn
    python3Packages.weasyprint
    python3Packages.python-magic
    javaPackages.compiler.openjdk25
    pre-commit
  ];
}
