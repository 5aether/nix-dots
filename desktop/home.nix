{ inputs, ... }:

{
  imports = [
    inputs.spicetify-nix.homeManagerModules.spicetify
    inputs.nixcord.homeModules.nixcord
    ./modules/home/bash.nix
    ./modules/home/cm-redirect.nix
    ./modules/home/discord.nix
    ./modules/home/git.nix
    ./modules/home/gtk.nix
    ./modules/home/foot.nix
    ./modules/home/neovim.nix
    ./modules/home/packages.nix
    ./modules/home/spicetify.nix
    ./modules/home/sway.nix
    ./modules/home/swaync.nix
    ./modules/home/vicinae.nix
    ./modules/home/waybar.nix
  ];

  home = {
    username = "aether";
    homeDirectory = "/home/aether";
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;
}
