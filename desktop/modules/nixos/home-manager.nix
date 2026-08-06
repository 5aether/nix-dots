{ inputs, ... }:

{
  home-manager = {
    useUserPackages = true;
    backupFileExtension = "bak";
    extraSpecialArgs = { inherit inputs; };
    users.aether = ../../home.nix;
  };
}
