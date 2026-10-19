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
      editor = {
        navic.enable = true;
      };
      ui.mini-indentscope.enable = true;

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

    config = {
      keymaps = ''
        vim.keymap.set("n", "<leader>b.", "<cmd>%y+<cr>", { desc = "Yank file to clipboard" })
      '';
    };

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
            { "<leader>cb", "<cmd>DevdocsOpenFloat<cr>", desc = "DevDocs (float)" },
            { "<leader>cD", "<cmd>DevdocsOpen<cr>", desc = "DevDocs (buffer)" },
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

      navbuddy = ''
        return {
          "SmiteshP/nvim-navbuddy",
          dependencies = {
            "SmiteshP/nvim-navic",
            "MunifTanjim/nui.nvim",
          },
          opts = function()
            local actions = require("nvim-navbuddy.actions")
            return {
              lsp = { auto_attach = true },
              mappings = {
                ["<Up>"] = actions.previous_sibling(),
                ["<Down>"] = actions.next_sibling(),
                ["<Left>"] = actions.parent(),
                ["<Right>"] = actions.children(),
              },
            }
          end,
          keys = {
            { "<leader>cn", "<cmd>Navbuddy<cr>", desc = "Navbuddy" },
          },
        }
      '';
    };
  };
}
