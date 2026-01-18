{ inputs, config, pkgs, ... }: {

  programs.nixvim = {
    enable = true;

    globals.mapleader = " ";
    globals.maplocalleader = " ";

    opts = {
      number = true;
      relativenumber = true;

      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      smartindent = true;

      ignorecase = true;
      smartcase = true;
      incsearch = true;

      termguicolors = true;
      cursorline = true;
      scrolloff = 8;
      signcolumn = "yes";

      updatetime = 250;
      undofile = true;
    };

    colorschemes.gruvbox.enable = true;
    plugins = {
      direnv = { enable = true; };
      trouble.enable = true;
      treesitter-textobjects.enable = true;
      todo-comments.enable = true;
      mini = {
        enable = true;
        modules = { icons = { }; };
        mockDevIcons = true;
      };
      telescope = {
        enable = true;
        enabledExtensions = [ "notify" ];
        extensions = {
          ui-select.enable = true;
          #         notify.enable = true;
        };
      };
      devdocs = { enable = true; };
      fidget.enable = true;
      notify.enable = true;
      oil.enable = true;
      lsp = {
        enable = true;
        inlayHints = true;
        servers = {
          basedpyright.enable = true;
          ruff.enable = true;
          nixd.enable = true;
          clangd = {
            enable = true;
            cmd = [
              "clangd"
              "--background-index"
              "--clang-tidy"
              "--header-insertion=never"
            ];
          };
        };

        #        servers.nixd.enable = true;
      };
      lightline.enable = true;
      treesitter.enable = true;
      nvim-autopairs.enable = true;
      comment.enable = true;
      which-key.enable = true;
      cmp_luasnip.enable = true;
      cmp-nvim-lsp.enable = true; # Add this!
      cmp-path.enable = true; # Recommended for file path completion
      cmp-buffer.enable = true; # Recommended for words in current file
      cmp = {
        enable = true;
        settings.snippet.expand =
          "function(args) require('luasnip').lsp_expand(args.body) end";
        settings.sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
        settings.mapping = {
          "<Tab>" = "cmp.mapping.select_next_item()";
          "<S-Tab>" = "cmp.mapping.select_prev_item()";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<C-Space>" = "cmp.mapping.complete()"; # Optional: Manual trigger
        };
      };
      cmp-treesitter = { enable = true; };
      conform-nvim = {
        enable = true;
        settings.format_on_save = {
          lsp_fallback = true;
          timeout_ms = 500;
        };
        settings.formatters_by_ft = { nix = [ "nixfmt" ]; };
      };
      dap.enable = true;
      dap-lldb = {
        enable = true;
        settings.codelldb_path =
          "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
      };
      dap-ui = { enable = true; };

      dap-virtual-text.enable = true;

      rustaceanvim = {
        enable = true;
        settings.dap.autoloadConfigurations = true;
      };

      gitsigns.enable = true;

      luasnip.enable = true;

      treesitter-context.enable = true;

      indent-blankline.enable = true;

    };

    extraPackages = with pkgs; [
      lldb
      vscode-extensions.vadimcn.vscode-lldb
      clang-tools
      basedpyright
      rust-analyzer
    ];

    keymaps = [
      {
        mode = "n";
        key = "<leader>K";
        action = "<cmd>DevdocsOpenCurrentFloat<cr>";
        options.desc = "Devdocs: Open for word under cursor";
      }
      {
        mode = "n";
        key = "<leader>sd";
        action = "<cmd>DevdocsOpen<cr>";
        options.desc = "Devdocs: Search documentation";
      }
      # Trouble
      {
        mode = "n";
        key = "<leader>xx";
        action = "<cmd>Trouble diagnostics toggle<cr>";
        options.desc = "Diagnostics (Trouble)";
      }
      # Todo Comments
      {
        mode = "n";
        key = "<leader>st";
        action = "<cmd>TodoTelescope<cr>";
        options.desc = "Search TODOs";
      }
      {
        mode = "n";
        key = "<F5>";
        action = "<cmd>lua require('dap').continue()<CR>";
        options.desc = "Debug: Start/Continue";
      }
      {
        mode = "n";
        key = "<F10>";
        action = "<cmd>lua require('dap').step_over()<CR>";
        options.desc = "Debug: Step Over";
      }
      {
        mode = "n";
        key = "<F11>";
        action = "<cmd>lua require('dap').step_into()<CR>";
        options.desc = "Debug: Step Into";
      }
      {
        mode = "n";
        key = "<leader>b";
        action = "<cmd>lua require('dap').toggle_breakpoint()<CR>";
        options.desc = "Debug: Toggle Breakpoint";
      }
      {
        mode = "n";
        key = "<leader>du";
        action = "<cmd>lua require('dapui').toggle()<CR>";
        options.desc = "Debug: Toggle UI";
      }
      {
        mode = "n";
        key = "<leader>ff"; # Example for Telescope
        action = "<cmd>Telescope find_files<CR>";
        options.desc = "Find Files";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<CR>";
        options.desc = "Live Grep";
      }
      {
        mode = "n";
        key = "<leader>ca";
        action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
        options.desc = "LSP: Code Actions";
      }
      {
        mode = "n";
        key = "gd";
        action = "<cmd>lua vim.lsp.buf.definition()<CR>";
        options.desc = "LSP: Go to Definition";
      }
      {
        mode = "n";
        key = "gr";
        action = "<cmd>Telescope lsp_references<CR>";
        options.desc = "LSP: Go to References";
      }
      {
        mode = "n";
        key = "K";
        action = "<cmd>lua vim.lsp.buf.hover()<CR>";
        options.desc = "LSP: Hover Documentation";
      }
      {
        mode = "n";
        key = "<leader>rn";
        action = "<cmd>lua vim.lsp.buf.rename()<CR>";
        options.desc = "LSP: Rename Symbol";
      }
      # Move lines up and down in Visual Mode
      {
        mode = "v";
        key = "J";
        action = ":m '>+1<CR>gv=gv";
        options.desc = "Move selection down";
      }
      {
        mode = "v";
        key = "K";
        action = ":m '<-2<CR>gv=gv";
        options.desc = "Move selection up";
      }
      # Keep cursor in center when jumping
      {
        mode = "n";
        key = "<C-d>";
        action = "<C-d>zz";
      }
      {
        mode = "n";
        key = "<C-u>";
        action = "<C-u>zz";
      }
      {
        mode = "n";
        key = "-"; # Traditional mapping for Oil
        action = "<cmd>Oil<CR>";
        options.desc = "Open parent directory in Oil";
      }
    ];

    extraConfigLua = ''
            local dap, dapui = require("dap"), require("dapui")
            dap.listeners.before.attach.dapui_config = function() dapui.open() end
            dap.listeners.before.launch.dapui_config = function() dapui.open() end
            dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
            dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

      -- Show line diagnostics automatically in hover window
            vim.api.nvim_create_autocmd("CursorHold", {
              callback = function()
                vim.diagnostic.open_float(nil, {
                  focusable = false,
                  close_events = { "CursorMoved", "CursorMovedI", "BufLeave" },
                  border = "rounded",
                  source = "always",
                  prefix = " ",
                  scope = "cursor",
                })
              end,
            })

    '';

  };
}
