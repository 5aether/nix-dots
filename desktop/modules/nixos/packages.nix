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
    pinentry

    ffmpeg
    ffmpegthumbnailer
    mpv
    libwebp
    libjxl
    librsvg
  ];
}
