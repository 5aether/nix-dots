{ config, ... }:

{
  programs.mars = {
    enable = true;
    systemdService = true;
  };
}
