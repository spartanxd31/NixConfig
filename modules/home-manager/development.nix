{ inputs, config, pkgs, ... }: {
  home.packages = with pkgs; [
    # Development tools
    bash
    gcc
    clang-tools
    python3
    rustc
    cargo
    nodejs
    rust-analyzer
    basedpyright
    ruff
    lldb
    vscode-extensions.vadimcn.vscode-lldb
    git

    # Build tools
    luarocks
    unzip

    # CLI utilities
    tree
    bat
    fzf
    ripgrep
    fd
    htop
    tmux
    screen
    stow
    lf
    procps
    util-linux
    usbutils

    # Version control
    git

    #remote desktop
    omnissa-horizon-client
  ];

  programs.git = {
    enable = true;
    settings = {
      user.name = "Domenic Marcelli";
      user.email = "spartanxd31@vt.edu";
    };
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };
}
