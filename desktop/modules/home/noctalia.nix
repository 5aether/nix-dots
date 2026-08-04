{ config, ... }:

{
  programs.noctalia = {
    enable = true;
    settings = ./noctalia.toml;
  };
}
