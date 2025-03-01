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
}
