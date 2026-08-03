{ inputs, config, ... }:

{
  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.aether = ../../home.nix;
  };
}
