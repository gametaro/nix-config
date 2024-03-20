{
  description = "nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";

    pre-commit-hooks-nix.url = "github:cachix/pre-commit-hooks.nix";
    pre-commit-hooks-nix.inputs.nixpkgs.follows = "nixpkgs";

    # hardware.url = "github:nixos/nixos-hardware";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    nix-colors.url = "github:misterio77/nix-colors";

    nur.url = "github:nix-community/NUR";

    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    neovim.url = "github:gametaro/neovim-flake";
    neovim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    inherit (nixpkgs) lib;
    systems = [
      "aarch64-linux"
      "x86_64-linux"
    ];
    pkgsFor = lib.genAttrs systems (system:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [inputs.devshell.overlays.default];
      });
    forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
  in {
    packages = forEachSystem (pkgs: import ./pkgs pkgs);
    formatter = forEachSystem (pkgs: pkgs.alejandra);
    checks = forEachSystem (pkgs: {
      pre-commit-hooks = inputs.pre-commit-hooks-nix.lib.${pkgs.system}.run {
        src = ./.;
        hooks = {
          alejandra.enable = true;
          deadnix.enable = false;
          nil.enable = true;
          statix.enable = true;
        };
      };
    });
    devShells = forEachSystem (
      pkgs:
        with pkgs; {
          default = devshell.mkShell {
            packages = [
              alejandra
              deadnix
              nil
              statix
            ];
            commands = [
              {
                name = "hm";
                category = "home-manager";
                command = "home-manager switch --flake .#gametaro@barling --impure -b backup";
              }
              {
                name = "os";
                category = "nixos";
                command = "sudo nixos-rebuild --flake .#barling switch";
              }
            ];
          };
        }
    );

    overlays = import ./overlays {inherit inputs;};
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    nixosConfigurations = {
      barling = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/configuration.nix
        ];
        specialArgs = {inherit inputs outputs;};
      };
    };

    homeConfigurations = {
      "gametaro@barling" = let
        system = "x86_64-linux";
      in
        home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor.${system};
          modules = [./home-manager/home.nix];
          extraSpecialArgs = {
            inherit inputs outputs;
            neovim = inputs.neovim.packages.${system}.default;
            firefox-addons = inputs.firefox-addons.packages.${system};
          };
        };
    };
  };
}
