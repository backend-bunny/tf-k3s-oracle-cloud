# resource "oci_core_instance" "server_0" {
#   compartment_id      = var.compartment_id
#   availability_domain = data.oci_identity_availability_domain.ad_1.name
#   display_name        = "k3s_server_0"
#   shape               = local.ampere_instance_config.shape_id
#   source_details {
#     source_id   = local.ampere_instance_config.source_id
#     source_type = local.ampere_instance_config.source_type
#   }
#   shape_config {
#     memory_in_gbs = local.ampere_instance_config.ram
#     ocpus         = 2
#   }
#   create_vnic_details {
#     subnet_id  = var.cluster_subnet_id
#     private_ip = cidrhost(var.cidr_blocks[0], 10)
#     nsg_ids    = [var.permit_ssh_nsg_id]
#   }
#  metadata = {
#    "ssh_authorized_keys" = local.micro_instance_config.metadata.ssh_authorized_keys
#    "user_data" = base64encode(<<EOT
#      #cloud-config
#      write_files:
#      - path: /etc/nixos/host.nix
#        permissions: '0644'
#        content: |
#          {
#            lib,
#            pkgs,
#            ...
#          }:
#          {
#            services.openssh = {
#              enable = true;
#              settings = {
#                PasswordAuthentication = false;
#                PermitRootLogin = "no";
#              }
#              ;
#            };
#            environment.systemPackages = map lib.lowPrio [
#              pkgs.busybox
#            ];
#            security.sudo.wheelNeedsPassword = false;
#            nix.settings.trusted-users = ["k3s"];
#            users.users.k3s = {
#              isNormalUser = true;
#              description = "k3s";
#              extraGroups = ["wheel" "users"];
#              shell = pkgs.bashInteractive;
#              openssh.authorizedKeys.keys = [ ${join(" ", formatlist("%q", var.ssh_authorized_keys))} ];
#            };
#          }
#      runcmd:
#        - curl https://raw.githubusercontent.com/elitak/nixos-infect/master/nixos-infect | NIXOS_IMPORT=/etc/nixos/host.nix NIX_CHANNEL=nixos-24.11 bash 2>&1 | tee /tmp/infect.log
#    EOT
#    )
#  }
# }
#
#resource "oci_core_instance" "server_2_3" {
#  count               = 2
#  compartment_id      = var.compartment_id
#  availability_domain = data.oci_identity_availability_domain.ad_1.name
#  display_name        = "k3s_server_${count.index + 1}"
#  shape               = local.ampere_instance_config.shape_id
#  source_details {
#    source_id   = local.ampere_instance_config.source_id
#    source_type = local.ampere_instance_config.source_type
#  }
#  shape_config {
#    memory_in_gbs = local.ampere_instance_config.ram
#    ocpus         = local.ampere_instance_config.ocpus
#  }
#  create_vnic_details {
#    subnet_id  = var.cluster_subnet_id
#    private_ip = cidrhost(var.cidr_blocks[0], count.index + 11)
#    nsg_ids    = [var.permit_ssh_nsg_id]
#  }
#  metadata = {
#    "ssh_authorized_keys" = local.micro_instance_config.metadata.ssh_authorized_keys
#    "user_data" = base64encode(<<EOT
#      #cloud-config
#      write_files:
#      - path: /etc/nixos/host.nix
#        permissions: '0644'
#        content: |
#          {
#            lib,
#            pkgs,
#            ...
#          }:
#          {
#            services.openssh = {
#              enable = true;
#              settings = {
#                PasswordAuthentication = false;
#                PermitRootLogin = "no";
#              }
#              ;
#            };
#            environment.systemPackages = map lib.lowPrio [
#              pkgs.busybox
#            ];
#            security.sudo.wheelNeedsPassword = false;
#            nix.settings.trusted-users = ["k3s"];
#            users.users.k3s = {
#              isNormalUser = true;
#              description = "k3s";
#              extraGroups = ["wheel" "users"];
#              shell = pkgs.bashInteractive;
#              openssh.authorizedKeys.keys = [ ${join(" ", formatlist("%q", var.ssh_authorized_keys))} ];
#            };
#          }
#      runcmd:
#        - curl https://raw.githubusercontent.com/elitak/nixos-infect/master/nixos-infect | NIXOS_IMPORT=/etc/nixos/host.nix NIX_CHANNEL=nixos-24.11 bash 2>&1 | tee /tmp/infect.log
#    EOT
#    )
#  }
#  depends_on = [oci_core_instance.server_0]
#}

resource "oci_core_instance" "server_0_1" {
  count               = 2
  compartment_id      = var.compartment_id
  availability_domain = data.oci_identity_availability_domain.ad_1.name
  display_name        = "k3s-server-${count.index + 1}"
  shape               = local.micro_instance_config.shape_id
  source_details {
    source_id   = local.micro_instance_config.source_id
    source_type = local.micro_instance_config.source_type
  }
  shape_config {
    memory_in_gbs = local.micro_instance_config.ram
    ocpus         = local.micro_instance_config.ocpus
  }
  create_vnic_details {
    subnet_id  = var.cluster_subnet_id
    private_ip = cidrhost(var.cidr_blocks[0], count.index + 20)
    nsg_ids    = [var.permit_ssh_nsg_id, var.permit_kube_api_nsg_id]
  }

  agent_config {
    plugins_config {
      name          = "OS Management Service Agent"
      desired_state = "DISABLED"
    }
  }
  metadata = {
    "ssh_authorized_keys" = local.micro_instance_config.metadata.ssh_authorized_keys
    "user_data" = base64encode(<<EOT
      #cloud-config
      write_files:
      - path: /etc/nixos/host.nix
        permissions: '0644'
        content: |
          {
            lib,
            pkgs,
            ...
          }:
          {
            services.openssh = {
              enable = true;
              settings = {
                PasswordAuthentication = false;
                PermitRootLogin = "no";
              }
              ;
            };
            environment.systemPackages = map lib.lowPrio [
              pkgs.busybox
            ];
            security.sudo.wheelNeedsPassword = false;
            nix.settings.trusted-users = ["k3s"];
            users.users.k3s = {
              isNormalUser = true;
              description = "k3s";
              extraGroups = ["wheel" "users"];
              shell = pkgs.bashInteractive;
              openssh.authorizedKeys.keys = [ ${join(" ", formatlist("%q", var.ssh_authorized_keys))} ];
            };
          }
      runcmd:
        - curl https://raw.githubusercontent.com/elitak/nixos-infect/master/nixos-infect | NIXOS_IMPORT=/etc/nixos/host.nix NIX_CHANNEL=nixos-24.11 bash 2>&1 | tee /tmp/infect.log
    EOT
    )
  }
  #depends_on = [oci_core_instance.server_2_3]
}

# Takes around 15min for nixos-infect to work it's magic
resource "time_sleep" "wait_15_min" {
  depends_on      = [oci_core_instance.server_0_1]
  create_duration = "15m"
}

resource "local_file" "k3s_secrets_copy" {
  source   = var.k3s_secrets_file_path
  filename = "${path.module}/k3s_secrets.yaml"
}

module "system-build" {
  for_each  = { for idx, instance in oci_core_instance.server_0_1 : idx => instance }
  source    = "github.com/nix-community/nixos-anywhere//terraform/nix-build?ref=1.7.0"
  attribute = "${path.module}#nixosConfigurations.k3s-cp-${tostring(each.key + 1)}.config.system.build.toplevel"
  special_args = {
    terraform = {
      hostname                 = each.value.display_name
      ssh_authorized_keys_json = jsonencode(var.ssh_authorized_keys),
      lb_addr                  = var.lb_ip_address_details[0].ip_address
      k3s_secrets_yaml         = resource.local_file.k3s_secrets_copy.content_base64
    }
  }
  depends_on = [time_sleep.wait_15_min]
}

module "deploy" {
  for_each = { for idx, instance in module.system-build : idx => instance }
  source   = "github.com/nix-community/nixos-anywhere//terraform/nixos-rebuild?ref=1.7.0"

  ignore_systemd_errors = true
  nixos_system          = module.system-build[each.key].result.out
  target_host           = oci_core_instance.server_0_1[each.key].public_ip
  target_user           = "k3s"

  depends_on = [time_sleep.wait_15_min]
}
