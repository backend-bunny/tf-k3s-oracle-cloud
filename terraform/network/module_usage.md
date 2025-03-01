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
| [oci_core_default_route_table.internet_route_table](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_default_route_table) | resource |
| [oci_core_default_security_list.default_list](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_default_security_list) | resource |
| [oci_core_internet_gateway.internet_gateway](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_internet_gateway) | resource |
| [oci_core_network_security_group.permit_kube_api](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_network_security_group) | resource |
| [oci_core_network_security_group.permit_ssh](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_network_security_group) | resource |
| [oci_core_network_security_group_security_rule.permit_kube_api](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_network_security_group_security_rule) | resource |
| [oci_core_network_security_group_security_rule.permit_ssh](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_network_security_group_security_rule) | resource |
| [oci_core_subnet.cluster_subnet](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_subnet) | resource |
| [oci_core_vcn.cluster_network](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/core_vcn) | resource |
| [oci_identity_availability_domain.ad](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/identity_availability_domain) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_blocks"></a> [cidr\_blocks](#input\_cidr\_blocks) | CIDRs of the network, use index 0 for everything | `list(any)` | n/a | yes |
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | OCI Compartment ID | `string` | n/a | yes |
| <a name="input_managemnet_network"></a> [managemnet\_network](#input\_managemnet\_network) | Subnet allowed to ssh to hosts | `string` | n/a | yes |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | The tenancy OCID. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ad"></a> [ad](#output\_ad) | n/a |
| <a name="output_cluster_subnet"></a> [cluster\_subnet](#output\_cluster\_subnet) | Subnet of the k3s cluser |
| <a name="output_permit_kube_api"></a> [permit\_kube\_api](#output\_permit\_kube\_api) | NSG to permit kubeapi |
| <a name="output_permit_ssh"></a> [permit\_ssh](#output\_permit\_ssh) | NSG to permit ssh |
| <a name="output_vcn"></a> [vcn](#output\_vcn) | Created VCN |
