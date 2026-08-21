{ inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.default
    inputs.mars-display.nixosModules.default
    ./modules/nixos/boot.nix
    ./modules/nixos/cups.nix
    ./modules/nixos/fonts.nix
    ./modules/nixos/home-manager.nix
    ./modules/nixos/hyprland.nix
    ./modules/nixos/locale-time.nix
    ./modules/nixos/mars-display.nix
    ./modules/nixos/networking.nix
    ./modules/nixos/nvidia.nix
    ./modules/nixos/packages.nix
    ./modules/nixos/pipewire.nix
    ./modules/nixos/repos.nix
    ./modules/nixos/services.nix
    ./modules/nixos/steam.nix
    ./modules/nixos/tailscale.nix
    ./modules/nixos/users.nix
    ./modules/nixos/x11.nix
    ./drives.nix
  ];

  fileSystems."/mnt/Volume" = {
    device = "/dev/disk/by-label/Volume";
    fsType = "ext4";
    options = [
      "nofail"
      "noatime"
      "exec"
      "x-gvfs-show"
      "x-gvfs-name=Volume"
    ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "26.05";
}
