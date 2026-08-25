{ config, pkgs, ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_zen;
    # OBS Camera
    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 close_delay=0 card_label="OBS Virtual Camera" exclusive_caps=1
    '';
    # Fix for some steam games
    kernel.sysctl = {
      "vm.max_map_count" = 2147483642;
    };
  };

  # Better FFB Support
  hardware.new-lg4ff.enable = true;

  # App Image Compatibility
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # Scheduler
  services.scx = {
    enable = true;
    scheduler = "scx_lavd";
    extraArgs = [ "--performance" "--pinned-slice-us" "500" ];
  };

  # DDCutil
  hardware.i2c.enable = true;
  services.udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
  '';
}
