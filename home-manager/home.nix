# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs, lib, config, pkgs, ... }:
let dotfiles = inputs.dotfiles;
in {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    inputs.spicetify-nix.homeManagerModules.default
  ];

  # let 
  #     dotfiles = inputs.dotfiles;
  #   in {
  #     home.file.".config/ki"
  # }

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:lsp
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  # TODO: Set your username
  home = {
    username = "dom";
    homeDirectory = "/home/dom";
  };

  home.packages = with pkgs; [
    tree
    bash
    ruff
    unzip
    bat
    hyprcursor
    fzf
    ripgrep
    discord
    kitty
    xorg.xhost
    stow
    wofi
    heroic
    spicetify-cli
    rofi
    tmux
    waybar
    starship
    steam
    lf
    screen
    fd
    icu
    ruff
    freecad
    obs-studio
    xorg.xinit
    swaynotificationcenter
    wlogout
    via
    clang-tools
  ];

  home.file.".config/kitty".source = "${dotfiles}/kitty/.config/kitty/";

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
      fidget.enable = true;
      notify.enable = true;
      oil.enable = true;
      lsp = {
        enable = true;
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
      cmp-nvim-lsp.enable = true; # Add this!
      cmp-path.enable = true; # Recommended for file path completion
      cmp-buffer.enable = true; # Recommended for words in current file
      cmp = {
        enable = true;
        settings.snippet.expand =
          "function(args) require('luasnip').lsp_expand(args.body) end";
        settings.sources =
          [ { name = "nvim-lsp"; } { name = "path"; } { name = "buffer"; } ];
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
  programs.kitty = { enable = true; };

  programs.spicetify = let
    spicePkgs =
      inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  in {
    enable = true;
    theme = spicePkgs.themes.onepunch;
  };

  home.sessionPath = [

    "$HOME/.local/bin"

  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user.name = "Domenic Marcelli";
      user.email = "spartanxd31@vt.edu";

    };
  };

  programs.fastfetch = { enable = true; };

  programs.firefox.enable = true;

  #TODO: Need to make tpm a submodule to make this work
  home.file.".tmux".source = "${dotfiles}/tmux/.tmux/";

  # programs.tmux = {
  #   enable = true;
  #   plugins = with pkgs.tmuxPlugins; [ tpm tmux-sensible tmux-resurrect ];
  # };

  programs.bash.enable = true;

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };

  programs.ripgrep = { enable = true; };

  programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      # add_newline = false;

      # character = {
      #   success_symbol = "[➜](bold green)";
      #   error_symbol = "[➜](bold red)";
      # };

      # package.disabled = true;
    };
  };

  home.file.".config/starship.toml".source =
    "${dotfiles}/starship/.config/starship.toml";

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };

  # home.file.".config/nvim".source = "${dotfiles}/nvim/.config/nvim";

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.11";
}
