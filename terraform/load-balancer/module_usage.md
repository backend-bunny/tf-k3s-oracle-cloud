## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [oci_load_balancer_backend.k3s_kube_api_backend](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/load_balancer_backend) | resource |
| [oci_load_balancer_backend_set.k3s_kube_api_backend_set](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/load_balancer_backend_set) | resource |
| [oci_load_balancer_listener.k3s_kube_api_listener](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/load_balancer_listener) | resource |
| [oci_load_balancer_load_balancer.k3s_load_balancer](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/load_balancer_load_balancer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_subnet_id"></a> [cluster\_subnet\_id](#input\_cluster\_subnet\_id) | Subnet for the bastion instance | `string` | n/a | yes |
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | OCI Compartment ID | `string` | n/a | yes |
| <a name="input_k3s_server_instances_0_1_priv_ips"></a> [k3s\_server\_instances\_0\_1\_priv\_ips](#input\_k3s\_server\_instances\_0\_1\_priv\_ips) | Private IPs for k3s servers | `list(string)` | n/a | yes |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | The tenancy OCID. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lb_ip_address_details"></a> [lb\_ip\_address\_details](#output\_lb\_ip\_address\_details) | n/a |
