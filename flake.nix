{
  description = "Trasha's NixOS + Home Manager flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    lazyvim.url = "github:pfassina/lazyvim-nix";
    lazyvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      lazyvim,
      ...
    }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          # This tells nixpkgs to allow unfree for the whole system
          {
            nixpkgs.config.allowUnfree = true;
          }

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true; # Use the system's nixpkgs (with unfree allowed)
              useUserPackages = true;
              extraSpecialArgs = { inherit lazyvim; };
              users.trasha = import ./home.nix; # Don't pass {inherit pkgs;} here
              backupFileExtension = "backup";
            };
          }
        ];
      };
    };
}
