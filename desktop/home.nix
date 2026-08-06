{ inputs, config, pkgs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
    inputs.spicetify-nix.homeManagerModules.spicetify
    inputs.waterfox-flake.homeManagerModules.default
    ./modules/home/noctalia/package.nix
    ./modules/home/bash.nix
    ./modules/home/git.nix
    ./modules/home/gtk.nix
    ./modules/home/kitty.nix
    ./modules/home/neovim.nix
    ./modules/home/niri.nix
    ./modules/home/packages.nix
    ./modules/home/spicetify.nix
  ];

  home = {
    username = "aether";
    homeDirectory = "/home/aether";
    stateVersion = "26.11";
  };

  programs.home-manager.enable = true;
}
