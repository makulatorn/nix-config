{
  description = "Trasha's NixOS config as a flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    cms.url = "path:/home/trasha/web-skole/cms";
  };

  outputs = { self, nixpkgs, cms, ... }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
        ];
      };
    };
  };
}
