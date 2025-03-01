variable "compartment_id" {
  description = "OCI Compartment ID"
  type        = string
}

variable "fingerprint" {
  description = "The fingerprint of the key to use for signing"
  type        = string
}

variable "private_key_path" {
  description = "Private key to use for signing"
  type        = string
}

variable "private_key_password" {
  description = "Password for private key to use for signing"
  type        = string
  default     = null
}

variable "region" {
  description = "The region to connect to."
  type        = string
}

variable "tenancy_ocid" {
  description = "The tenancy OCID."
  type        = string
}

variable "user_ocid" {
  description = "The user OCID."
  type        = string
}

variable "ssh_authorized_keys" {
  description = "List of authorized SSH keys"
  type        = list(any)
}

variable "ssh_ingress_allowed_network" {
  description = "Network specified in CIDR (eg: 0.0.0.0/32) for allowed"
  type        = string
}

locals {
  cidr_blocks = ["10.0.0.0/24"]
}
