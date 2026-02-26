resource "google_compute_network_peering" "peering_a_to_b" {
  name         = "${var.vpc_a_name}-to-${var.vpc_b_name}"
  network      = var.vpc_a_id
  peer_network = var.vpc_b_id
  export_custom_routes = true
  import_custom_routes = true
}

resource "google_compute_network_peering" "peering_b_to_a" {
  name         = "${var.vpc_b_name}-to-${var.vpc_a_name}"
  network      = var.vpc_b_id
  peer_network = var.vpc_a_id
  export_custom_routes = true
  import_custom_routes = true
}
