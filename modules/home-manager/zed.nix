{ inputs, config, pkgs, ... }: {

  home.packages = with pkgs; [ nix-ld ];
  programs.zed-editor = {
    enable = true;
    extensions = [ "rust" "nix" "neocmake" ];
    userSettings = {

      vim_mode = true;
      font_family = "FiraCode Nerd Font";
      shell = "system";
      lsp = {
        rust-analyzer = { binary = { path_lookup = true; }; };
        nix = { binary = { path_lookup = true; }; };
        neocmakelsp = { binary = { path_lookup = true; }; };
        clangd = { binary = { path_lookup = true; }; };
      };
      font_features = null;
      font_size = null;
      line_height = "comfortable";

      show_whitespaces = "all";
      load_direnv = "shell_hook";

    };
    installRemoteServer = true;
    extraPackages = with pkgs; [
      # General LSPs you want managed by Nix
      nixd
      nil
      cmake

      # Common libraries that downloaded binaries often need
      zlib
      openssl
      stdenv.cc.cc.lib
    ];
  };

  home.sessionVariables = {
    NIX_LD_LIBRARY_PATH = "/run/current-system/sw/share/nix-ld/lib";
  };

  #  programs.nix-ld.enable = true;
  # home.file.".zed_server" = {
  #   source = "${pkgs.zed-editor.remote_server}/bin";
  #   recursive = true;
  # };
}
