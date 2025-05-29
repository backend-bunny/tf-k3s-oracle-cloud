{
  lib,
  pkgs,
  config,
  terraform,
  ...
}: {
  zramSwap.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
    hostKeys = [
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };

  services.tailscale = {
    enable = true;
    authKeyFile = config.sops.secrets."tailscale/${terraform.hostname}".path;
    disableTaildrop = true;
  };

  sops = {
    defaultSopsFile = ./. + "/${terraform.k3s_secrets_yaml}";
    # This automatically uses the SSH host key as an age key
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    # Optional: specify a fallback key if needed

    secrets = {
      # to generate token run `k3s token generate`
      # place under the key "k3s-token:" in sops secret file
      "k3s-token" = {
        owner = "root";
        group = "root";
        mode = "0400";
        restartUnits = ["k3s.service"];
      };
      "tailscale/${terraform.hostname}" = {
        restartUnits = ["tailscaled-autoconnect.service" "tailscaled.service"];
      };
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
      experimental-features = [ "nix-command" "flakes" ];
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

  systemd.services = {
    delete_old_root = {
      wantedBy = ["multi-user.target"];
      description = "Remove remnants of old Ubuntu file-system";
      path = [pkgs.busybox]; # Ensures `rm` is available
      enable = true;
      serviceConfig = {
        Type = "oneshot";
        User = "root";
        Group = "root";
      };
      script = "[ -d /old-root ] && rm -rf /old-root || exit 0";
    };
    stop_tailscale_first_boot = {
       wantedBy = ["multi-user.target"];
       description = "Manages tailscale systemd units based on secret availability";
       enable = true;
       serviceConfig = {
         Type = "oneshot";
         User = "root";
         Group = "root";
       };
       script = ''
         SECRET_PATH="${config.sops.secrets."tailscale/${terraform.hostname}".path}"

         if [ -f "$SECRET_PATH" ]; then
           echo "Tailscale secret found at $SECRET_PATH, starting tailscale services"
           systemctl start tailscaled.service
           systemctl start tailscaled-autoconnect.service
         else
           echo "Tailscale secret not found at $SECRET_PATH, stopping tailscale services"
           systemctl stop tailscaled-autoconnect.service
           systemctl stop tailscaled.service
         fi
       '';
    };
  };

  system.stateVersion = "24.11";
}


