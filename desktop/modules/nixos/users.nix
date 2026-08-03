{ config, ... }:

{
  users.users."aether" = {
    isNormalUser = true;
    description = "Aether";
    extraGroups = [ "networkmanager" "wheel" "input" ];
  };
}
