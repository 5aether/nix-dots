{
  description = "Aether's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    }; 

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    mars-display.url = "github:5aether/mars-display";

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    waterfox-flake.url = "github:5aether/waterfox-flake";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
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
