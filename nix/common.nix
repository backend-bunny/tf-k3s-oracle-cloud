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
      PermitRootLogin = "no";
    };
    hostKeys = [
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };

  system.activationScripts.writeBase64Content = ''
    # Write the base64 content to a stamp file
    mkdir -p /etc/secrets.d
    echo "${terraform.secrets_yaml}" > /etc/secrets.d/k3s-secrets.yaml.base64
    chmod 600 /etc/secrets.d/k3s-secrets.yaml.base64
  '';

  sops = {
    defaultSopsFile = /etc/secrets.d/k3s-secrets.yaml;
    # This automatically uses the SSH host key as an age key
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    # Optional: specify a fallback key if needed
    # age.keyFile = "/var/lib/sops-nix/key.txt";

    secrets = {
      # to generate token run `k3s token generate`
      # place under the key "k3s-token:" in sops secret file
      "k3s-token" = {
        owner = "root";
        group = "root";
        mode = "0400";
        restartUnits = [ "k3s.service" ];
      };
      # Add other secrets as needed
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
  systemd.services = {
    # Your other services...

    decode-base64-secrets_yaml = {
      wantedBy = [ "multi-user.target" ];
      description = "Decode Base64 encoded secrets.yaml and write to file";
      path = [ pkgs.busybox pkgs.coreutils ]; # Ensures base64 and other tools are available
      after = [ "network.target" ];
      enable = true;
      serviceConfig = {
        ExecStart = pkgs.writeShellScript "decode-secrets" ''
          SOURCE_FILE="/etc/secrets.d/k3s-secrets.yaml.base64"
          TARGET_FILE="/etc/secrets.d/k3s-secrets.yaml"

          # Check if target file exists
          if [ ! -f "$TARGET_FILE" ]; then
            NEEDS_UPDATE=1
          else
            # Compare modification timestamps
            SOURCE_TIME=$(stat -c %Y "$SOURCE_FILE")
            TARGET_TIME=$(stat -c %Y "$TARGET_FILE")

            if [ "$SOURCE_TIME" -gt "$TARGET_TIME" ]; then
              NEEDS_UPDATE=1
            else
              NEEDS_UPDATE=0
              echo "Decoded file is up to date, no action needed."
            fi
          fi

          # Only decode if needed
          if [ "$NEEDS_UPDATE" -eq 1 ]; then
            echo "Decoding base64 content to $TARGET_FILE"
            base64 -d < "$SOURCE_FILE" > "$TARGET_FILE"
            chmod 600 "$TARGET_FILE"
            echo "Decode completed successfully"
          fi
        '';
        Type = "oneshot";
        User = "root";
        Group = "root";
        RemainAfterExit = true;
      };
    };
  };

  system.stateVersion = "24.11";
}
