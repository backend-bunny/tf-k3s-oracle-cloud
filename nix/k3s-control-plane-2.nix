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

  networking.firewall.enable = false;

  environment.systemPackages = map lib.lowPrio [
    pkgs.busybox
    #add packages here
  ];
  services.k3s = {
    enable = true;
    role = "agent";
    token = terraform.cluster_token;
    serverAddr = "https://${terraform.lb_addr}:6443";
#    clusterInit = true;
    gracefulNodeShutdown = {
      enable = true;
    };
  };
}
