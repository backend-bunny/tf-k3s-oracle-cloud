{
  lib,
  pkgs,
  config,
  terraform,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./common.nix
  ];

  networking.hostName = terraform.hostname;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      2379
      2380 # etcd (only needed for HA)
      6443 # Kubernetes API Server
      10250 # Kubelet metrics
    ];
    allowedUDPPorts = [
      8472 # Flannel VXLAN
      51820 # Flannel Wireguard (IPv4)
    ];
  };

  environment.systemPackages = map lib.lowPrio [
    pkgs.busybox
    #add packages here
  ];
  services.k3s = {
    enable = true;
    role = "agent";
    tokenFile = config.sops.secrets."k3s-token".path;
    serverAddr = "https://${terraform.lb_addr}:6443";
    #    clusterInit = true;
    gracefulNodeShutdown = {
      enable = true;
    };
  };
}
