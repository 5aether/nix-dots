{ pkgs, ... }:

{
  # Caelestia needs that
  programs.gpu-screen-recorder.enable = true;

  environment.systemPackages = with pkgs; [
    # Caelestia
    matugen
  ];
}
