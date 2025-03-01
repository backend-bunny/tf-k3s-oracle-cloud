output "ad" {
  value = data.oci_identity_availability_domain.ad_1.name
}

output "cluster_token" {
  value = random_string.cluster_token.result
}

output "instance_0_1_priv_ips" {
  #value = oci_core_instance.server_0_1[*].private_ip
  value = [for instance in oci_core_instance.server_0_1 : instance.private_ip]
}