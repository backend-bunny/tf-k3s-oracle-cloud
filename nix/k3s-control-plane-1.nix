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

  # Open required TCP and UDP ports
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      2379
      2380 # etcd (only needed for HA)
      6443 # Kubernetes API Server / Spegel
      10250 # Kubelet metrics
      5001 # Embedded distributed registry (Spegel)
    ];
    allowedUDPPorts = [
      8472 # Flannel VXLAN
      51820 # Flannel Wireguard (IPv4)
      51821 # Flannel Wireguard (IPv6)
    ];
  };

  services.k3s = {
    enable = true;
    role = "server";
    token = terraform.cluster_token;
    clusterInit = true;
    extraFlags = ["--disable=servicelb,traefik,local-storage,metrics-server" "--cluster-cidr 10.24.0.0/16"];
    gracefulNodeShutdown = {
      enable = true;
    };
  };
}
