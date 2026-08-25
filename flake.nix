{
  description = "Aether's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    mars-display.url = "github:5aether/mars-display";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    nixcord.url = "github:4evy/nixcord";

    awt.url = "github:5aether/awt";

    ast.url = "github:5aether/ast";
  };

  outputs = inputs@{ self, nixpkgs, ... }: {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./desktop/config.nix
        ];
      };
    };
  };
}
