{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # --- LANG RUNTIME/MANAGERS ---
    python3
    python3Packages.pip
    nodejs
    typescript
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
    yaml-language-server
    nixd
    marksman
    taplo
    emmet-ls
    clojure-lsp

    # --- FORMATTERS/LINTERS ---
    prettier
    prettierd
    shellcheck
    shfmt
    dockfmt
    nixfmt
    stylelint
    cljfmt
    libxml2

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
    git
    javaPackages.compiler.openjdk25
    pre-commit
  ];
}
