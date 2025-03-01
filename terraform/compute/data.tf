data "oci_identity_availability_domain" "ad_1" {
  compartment_id = var.tenancy_ocid
  ad_number      = 1
}

resource "random_string" "cluster_token" {
  length  = 48
  special = false
  numeric = true
  lower   = true
  upper   = true
}

data "oci_core_images" "amd64_image" {
  compartment_id           = var.compartment_id
  operating_system         = "Canonical Ubuntu"
  operating_system_version = "20.04"
  shape                    = "VM.Standard.E4.Flex"
}

data "oci_core_images" "aarch64_image" {
  #display_name             = "Canonical Ubuntu 24.04 Minimal aarch64"
  compartment_id           = var.compartment_id
  operating_system         = "Canonical Ubuntu"
  operating_system_version = "20.04"
  shape                    = "VM.Standard.A1.Flex"
}
