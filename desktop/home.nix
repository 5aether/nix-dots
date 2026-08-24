{ inputs, ... }:

{
  imports = [
    inputs.spicetify-nix.homeManagerModules.spicetify
    ./modules/home/bash.nix
    ./modules/home/btop.nix
    ./modules/home/cm-redirect.nix
    ./modules/home/git.nix
    ./modules/home/gtk.nix
    ./modules/home/kitty.nix
    ./modules/home/neovim.nix
    ./modules/home/packages.nix
    ./modules/home/spicetify.nix
    ./modules/home/sway.nix
  ];

  home = {
    username = "aether";
    homeDirectory = "/home/aether";
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;
}
