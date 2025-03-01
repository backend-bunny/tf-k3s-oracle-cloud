{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  environment.systemPackages = map lib.lowPrio [
    pkgs.busybox
    #add packages here
  ];
}
