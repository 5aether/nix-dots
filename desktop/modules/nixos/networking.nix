{
  networking = {
    hostName = "desktop";
    wireless.enable = true;
    networkmanager.enable = true;
  };

  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNS = [ "192.168.1.200" ];
      FallbackDNS = [ "1.1.1.1" ];
    };
  };
}
