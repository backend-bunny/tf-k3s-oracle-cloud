## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_deploy"></a> [deploy](#module\_deploy) | github.com/nix-community/nixos-anywhere//terraform/nixos-rebuild | 1.7.0 |
| <a name="module_system-build"></a> [system-build](#module\_system-build) | github.com/nix-community/nixos-anywhere//terraform/nix-build | 1.7.0 |

## Resources

| Name | Type |
|------|------|
| [oci_core_instance.server_0_1](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_instance) | resource |
| [random_string.cluster_token](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [time_sleep.wait_15_min](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [oci_core_images.aarch64_image](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/core_images) | data source |
| [oci_core_images.amd64_image](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/core_images) | data source |
| [oci_identity_availability_domain.ad_1](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/identity_availability_domain) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_blocks"></a> [cidr\_blocks](#input\_cidr\_blocks) | CIDRs of the network, use index 0 for everything | `list(any)` | n/a | yes |
| <a name="input_cluster_subnet_id"></a> [cluster\_subnet\_id](#input\_cluster\_subnet\_id) | Subnet for the bastion instance | `string` | n/a | yes |
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | OCI Compartment ID | `string` | n/a | yes |
| <a name="input_lb_ip_address_details"></a> [lb\_ip\_address\_details](#input\_lb\_ip\_address\_details) | lb ip address details | `any` | n/a | yes |
| <a name="input_nixos_infect_path"></a> [nixos\_infect\_path](#input\_nixos\_infect\_path) | Filepath to nixos-infext.nix | `string` | `"../nix/nixos-infect.nix"` | no |
| <a name="input_permit_kube_api_nsg_id"></a> [permit\_kube\_api\_nsg\_id](#input\_permit\_kube\_api\_nsg\_id) | NSG to permit SSH | `string` | n/a | yes |
| <a name="input_permit_ssh_nsg_id"></a> [permit\_ssh\_nsg\_id](#input\_permit\_ssh\_nsg\_id) | NSG to permit SSH | `string` | n/a | yes |
| <a name="input_ssh_authorized_keys"></a> [ssh\_authorized\_keys](#input\_ssh\_authorized\_keys) | List of authorized SSH keys | `list(any)` | n/a | yes |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | The tenancy OCID. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ad"></a> [ad](#output\_ad) | n/a |
| <a name="output_cluster_token"></a> [cluster\_token](#output\_cluster\_token) | n/a |
| <a name="output_instance_0_1_priv_ips"></a> [instance\_0\_1\_priv\_ips](#output\_instance\_0\_1\_priv\_ips) | n/a |
