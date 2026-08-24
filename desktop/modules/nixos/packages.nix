{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    grim
    slurp
    xdg-utils
    rofi
    nautilus
    fastfetch
    wl-clipboard
    ddcutil
    vicinae

    ffmpeg
    ffmpegthumbnailer
    mpv
    libwebp
    libjxl
    librsvg
  ];
}
