{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    maple-mono.NF-CN
    liberation_ttf
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "Maple Mono NF CN" "Noto Sans CJK JP" ];
      sansSerif = [ "Maple Mono NF CN" "Noto Sans CJK JP" ];
      serif     = [ "Maple Mono NF CN" "Noto Serif CJK JP" ];
      emoji     = [ "Noto Color Emoji" ];
    };
  };
}
