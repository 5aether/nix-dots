{ pkgs, ... }:

{
  home.packages = with pkgs; [
    waybar

    # Editor
    zed-editor

    # Social
    equibop
    materialgram

    # Gaming
    heroic
    supertuxkart
    lunar-client

    # Media
    feishin
  ];

  programs.librewolf = {
    enable = true;
  };

  nixpkgs.config.allowUnfree = true;
}
