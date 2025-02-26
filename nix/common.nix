{
  lib,
  pkgs,
  terraform,
  ...
}: {
  zramSwap.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "yes";
    };
  };

  security.sudo.wheelNeedsPassword = false;



  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    #add packages here
  ];

  nix = {
    settings = {
      auto-optimise-store = true;
      trusted-users = ["k3s"];
    };
    gc = {
      automatic = true;
      dates = "weekly";
    };
  };

  users.users.k3s = {
    isNormalUser = true;
    description = "k3s";
    extraGroups = ["wheel" "users"];
    shell = pkgs.bashInteractive;
    openssh.authorizedKeys.keys = builtins.fromJSON terraform.ssh_authorized_keys_json;
  };

  nixpkgs.config.allowUnfree = true;

  systemd.services.delete_old_root = {
    wantedBy = ["multi-user.target"];
    path = [pkgs.coreutils]; # Ensures `rm` is available
    enable = true;
    serviceConfig = {
     Type = "oneshot";
      User = "root";
      Group = "root";
    };
    script = "[ -d /old-root ] && rm -rf /old-root || exit 0";
  };

  system.stateVersion = "24.11";
}