{ config, ... }:

{
  programs.noctalia = {
    enable = true;
    settings = ./config.toml;
  };
}
