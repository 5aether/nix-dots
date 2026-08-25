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
    btop
    playerctl
    rbw

    ffmpeg
    ffmpegthumbnailer
    mpv
    libwebp
    libjxl
    librsvg
  ];
}
