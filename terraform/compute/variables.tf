variable "compartment_id" {
  description = "OCI Compartment ID"
  type        = string
}

variable "tenancy_ocid" {
  description = "The tenancy OCID."
  type        = string
}

variable "cluster_subnet_id" {
  description = "Subnet for the bastion instance"
  type        = string
}

variable "permit_ssh_nsg_id" {
  description = "NSG to permit SSH"
  type        = string
}

variable "permit_kube_api_nsg_id" {
  description = "NSG to permit SSH"
  type        = string
}

variable "ssh_authorized_keys" {
  description = "List of authorized SSH keys"
  type        = list(any)
}

variable "cidr_blocks" {
  description = "CIDRs of the network, use index 0 for everything"
  type        = list(any)
}

variable "lb_ip_address_details" {
  description = "lb ip address details"
}

variable "nixos_infect_path" {
  description = "Filepath to nixos-infext.nix"
  type        = string
  default     = "../nix/nixos-infect.nix"
}

variable "k3s_secrets_file_path" {
  description = "Filepath to sops encrypted file containg secrets for k3s nodes"
  type        = string
}

locals {
  ampere_instance_config = {
    shape_id = "VM.Standard.A1.Flex"
    ocpus    = 1
    ram      = 8

    source_id   = data.oci_core_images.aarch64_image.images[0].id
    source_type = "image"

    metadata = {
      "ssh_authorized_keys" = join("\n", var.ssh_authorized_keys)
    }
  }
  micro_instance_config = {
    shape_id = "VM.Standard.E2.1.Micro"
    ocpus    = 1
    ram      = 1

    source_id   = data.oci_core_images.amd64_image.images[0].id
    source_type = "image"

    metadata = {
      "ssh_authorized_keys" = join("\n", var.ssh_authorized_keys)
    }
  }
}
