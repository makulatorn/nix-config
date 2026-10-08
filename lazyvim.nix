{
  pkgs,
  lib,
  lazyvim,
  ...
}:

{
  imports = [ lazyvim.homeManagerModules.default ];

  programs.lazyvim = {
    enable = true;

    extras = {
      lang = {
        nix.enable = true;
        python = {
          enable = true;
          installDependencies = true;
          installRuntimeDependencies = true;
        };
        typescript.enable = true;
      };
    };

    extraPackages = with pkgs; [
      nixd
      nixfmt
      curl
      pyright
      ruff
      typescript-language-server
      vscode-langservers-extracted
      statix
      nil
    ];

    plugins = {
      devdocs = ''
        return {
          "ayoisaiah/nvim-devdocs",
          dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "nvim-treesitter/nvim-treesitter",
          },
          opts = {
            ensure_installed = { "python~3.12", "django~5.0", "html", "css", "javascript", "typescript", "nix" },
          },
          keys = {
            { "<leader>sD", "<cmd>DevdocsOpenFloat<cr>", desc = "DevDocs (float)" },
            { "<leader>sd", "<cmd>DevdocsOpen<cr>", desc = "DevDocs (buffer)" },
          },
        }
      '';

      multicursor = ''
        return {
        "mg979/vim-visual-multi",
        event = "VeryLazy",
        }
      '';

      gitsigns = ''
        return {
          "lewis6991/gitsigns.nvim",
          opts = { current_line_blame = true },
        }
      '';

      colorscheme = ''
        return {
          "LazyVim/LazyVim",
          opts = { colorscheme = "quiet" },
        }
      '';
    };
  };
}
