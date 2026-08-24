{ config, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];
  boot.blacklistedKernelModules = [ "nouveau" ];
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      open = true;
      modesetting.enable = true;
      nvidiaSettings = false;
      powerManagement = {
        enable = true;
        finegrained = false;
      };
    };
  };
}
