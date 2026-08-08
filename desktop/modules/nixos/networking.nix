{
  networking = {
    hostName = "desktop";
    wireless.enable = true;
    nameservers = [ "192.168.1.200" ];
    networkmanager.enable = true;
  };

  services.resolved = {
    enable = true;
    settings.Resolve.FallbackDNS = [
      "1.1.1.1"
    ];
  };
}
