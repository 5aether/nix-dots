{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # System
    rofi
    xwayland-satellite
    nautilus
    fastfetch
    wl-clipboard
    ddcutil

    # Editor
    zed-editor

    # Social
    equibop
    materialgram

    # Gaming
    heroic
    supertuxkart
    lunar-client

    # Media
    feishin

    # VideoThumbnail
    ffmpeg
    ffmpegthumbnailer
    mpvpaper
    mpv
    libwebp
    libjxl
    librsvg
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
  ];

  programs.librewolf = {
    enable = true;
  };

  nixpkgs.config.allowUnfree = true;
}
