{
  description = "Trasha's NixOS + Home Manager flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:

  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    # NixOS configuration
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = system;
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
        ];
      };
    };

    # Home Manager configuration (top-level)
    homeConfigurations = {
      trasha = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs;
        username = "trasha";
        homeDirectory = "/home/trasha";
        configuration = import ./home.nix { pkgs = pkgs; };
      };
    };
  };
}
