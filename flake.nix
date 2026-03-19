{
  description =
    "Flakes config based on minimal config from https://github.com/Misterio77/nix-starter-configs/tree/main";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:NixOS/nixos-hardware";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    #Spicetify
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    #stylix
    stylix = {
      url = "github:danth/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #zen bzen-browser
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #dotfiles
    dotfiles.url = "github:spartanxd31/dotfiles";
    dotfiles.flake = false;

    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, hardware, stylix
    , dotfiles, nixvim, ... }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        # FIXME replace with your hostname
        nixos = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs pkgs-unstable; };
          # > Our main nixos configuration file <
          modules = [
            stylix.nixosModules.stylix
            ./nixos/configuration.nix
            { nix.settings = { download-buffer-size = 524288000; }; }
          ];

        };
      };

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        # FIXME replace with your username@hostname
        "dom@nixos" = home-manager.lib.homeManagerConfiguration {
          pkgs =
            nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
          extraSpecialArgs = { inherit inputs outputs pkgs-unstable; };
          # > Our main home-manager configuration file <
          modules = [
            nixvim.homeModules.nixvim
            stylix.homeModules.stylix
            ./home-manager/home.nix

          ];
        };
      };
    };
}
