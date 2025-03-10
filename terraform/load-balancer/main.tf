resource "oci_load_balancer_load_balancer" "k3s_load_balancer" {
  lifecycle {
    ignore_changes = [network_security_group_ids]
  }

  compartment_id = var.compartment_id
  display_name   = "k3s-kubeapi-load-balancer"
  shape          = "flexible"
  subnet_ids     = [var.cluster_subnet_id]

  ip_mode    = "IPV4"
  is_private = true

  shape_details {
    maximum_bandwidth_in_mbps = 10
    minimum_bandwidth_in_mbps = 10
  }
}

resource "oci_load_balancer_listener" "k3s_kube_api_listener" {
  default_backend_set_name = oci_load_balancer_backend_set.k3s_kube_api_backend_set.name
  load_balancer_id         = oci_load_balancer_load_balancer.k3s_load_balancer.id
  name                     = "K3s__kube_api_listener"
  port                     = 6443
  protocol                 = "TCP"
}

resource "oci_load_balancer_backend_set" "k3s_kube_api_backend_set" {
  health_checker {
    protocol = "TCP"
    port     = 6443
  }
  load_balancer_id = oci_load_balancer_load_balancer.k3s_load_balancer.id
  name             = "K3s__kube_api_backend_set"
  policy           = "ROUND_ROBIN"
}

resource "oci_load_balancer_backend" "k3s_kube_api_backend" {
  #count         = length(var.k3s_server_instances_0_1_priv_ips)
  backendset_name  = oci_load_balancer_backend_set.k3s_kube_api_backend_set.name
  ip_address       = var.k3s_server_instances_0_1_priv_ips[0] #[count.index]
  load_balancer_id = oci_load_balancer_load_balancer.k3s_load_balancer.id
  port             = 6443
}