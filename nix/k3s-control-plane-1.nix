{
  lib,
  pkgs,
  terraform,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./common.nix
  ];

  networking.hostName = terraform.hostname;

  environment.systemPackages = map lib.lowPrio [
    pkgs.busybox
    #add packages here
  ];

  networking.firewall.enable = false;

  services.k3s = {
    enable = true;
    role = "server";
    token = terraform.cluster_token;
    clusterInit = true;
    extraFlags = [ "--disable=servicelb,traefik,local-storage,metrics-server" "--cluster-cidr 10.24.0.0/16" ];
    gracefulNodeShutdown = {
      enable = true;
    };
  };

}