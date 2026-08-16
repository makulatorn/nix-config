{
  description = "Trasha's NixOS + Home Manager flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      emacs-overlay,
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
            nixpkgs.overlays = [ emacs-overlay.overlays.default ];
          }

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true; # Use the system's nixpkgs (with unfree allowed)
            home-manager.useUserPackages = true;
            home-manager.users.trasha = import ./home.nix; # Don't pass {inherit pkgs;} here
            home-manager.backupFileExtension = "backup";
          }
        ];
      };
    };
}
