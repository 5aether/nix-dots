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
    jq
    playerctl

    ffmpeg
    ffmpegthumbnailer
    mpv
    libwebp
    libjxl
    librsvg
  ];
}
