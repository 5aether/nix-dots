{
  networking = {
    hostName = "desktop";
    networkmanager.enable = true;
    nameservers = [ "192.168.1.200" ];
  };

  services.resolved = {
    enable = false;
  };
}
