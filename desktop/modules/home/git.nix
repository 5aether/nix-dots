{ config, pkgs, ... }:

{
  home.packages = [ pkgs.git pkgs.gh ];
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "5aether";
        email = "186336097+5aether@users.noreply.github.com";
      };
    };
  };
}
