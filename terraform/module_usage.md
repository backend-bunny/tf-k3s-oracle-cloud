## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_oci"></a> [oci](#requirement\_oci) | ~> 6.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | ~> 0.12 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_compute"></a> [compute](#module\_compute) | ./compute | n/a |
| <a name="module_load_balancer"></a> [load\_balancer](#module\_load\_balancer) | ./load-balancer | n/a |
| <a name="module_network"></a> [network](#module\_network) | ./network | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | OCI Compartment ID | `string` | n/a | yes |
| <a name="input_fingerprint"></a> [fingerprint](#input\_fingerprint) | The fingerprint of the key to use for signing | `string` | n/a | yes |
| <a name="input_git_ref"></a> [git\_ref](#input\_git\_ref) | Git reference of this module | `string` | `"main"` | no |
| <a name="input_private_key_password"></a> [private\_key\_password](#input\_private\_key\_password) | Password for private key to use for signing | `string` | `null` | no |
| <a name="input_private_key_path"></a> [private\_key\_path](#input\_private\_key\_path) | Private key to use for signing | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region to connect to. | `string` | n/a | yes |
| <a name="input_ssh_authorized_keys"></a> [ssh\_authorized\_keys](#input\_ssh\_authorized\_keys) | List of authorized SSH keys | `list(any)` | n/a | yes |
| <a name="input_ssh_ingress_allowed_network"></a> [ssh\_ingress\_allowed\_network](#input\_ssh\_ingress\_allowed\_network) | Network specified in CIDR (eg: 0.0.0.0/32) for allowed | `string` | n/a | yes |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | The tenancy OCID. | `string` | n/a | yes |
| <a name="input_user_ocid"></a> [user\_ocid](#input\_user\_ocid) | The user OCID. | `string` | n/a | yes |

## Outputs

No outputs.
