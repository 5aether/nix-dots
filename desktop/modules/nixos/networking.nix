{
  networking = {
    hostName = "desktop";
    networkmanager.enable = true;
  };

  services.resolved = {
    enable = true;
    dns = [ "192.168.1.200" ];
    domains = [ "~." ];
    dnsovertls = "false";
  };
}
