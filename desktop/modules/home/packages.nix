{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # System
    rofi
    xwayland-satellite
    nautilus
    fetch
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

  programs.waterfox = {
    enable = true;
    policies.DisableTelemetry = true;
  };

  nixpkgs.config.allowUnfree = true;
}
