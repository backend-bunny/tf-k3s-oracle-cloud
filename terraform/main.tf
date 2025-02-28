terraform {
  required_version = ">= 1.0.0"
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "~> 6.0"
      source  = "oracle/oci"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.12"
    }
  }
}

module "network" {
  source = "./network"

  compartment_id = var.compartment_id
  tenancy_ocid   = var.tenancy_ocid

  cidr_blocks        = local.cidr_blocks
  managemnet_network = var.ssh_ingress_allowed_network
}

module "compute" {
  source     = "./compute"
  depends_on = [module.network]

  compartment_id         = var.compartment_id
  tenancy_ocid           = var.tenancy_ocid
  cluster_subnet_id      = module.network.cluster_subnet.id
  permit_ssh_nsg_id      = module.network.permit_ssh.id
  permit_kube_api_nsg_id = module.network.permit_kube_api.id
  ssh_authorized_keys    = var.ssh_authorized_keys
  lb_ip_address_details  = module.load_balancer.lb_ip_address_details
  git_ref                = var.git_ref

  cidr_blocks = local.cidr_blocks
}

module "load_balancer" {
  source = "./load-balancer"
  #depends_on = [ module.compute ]

  k3s_server_instances_0_1_priv_ips = module.compute.instance_0_1_priv_ips
  compartment_id                    = var.compartment_id
  tenancy_ocid                      = var.tenancy_ocid
  cluster_subnet_id                 = module.network.cluster_subnet.id
}
