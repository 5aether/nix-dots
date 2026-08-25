{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Editor
    zed-editor

    # Social
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
