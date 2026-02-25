resource "google_compute_route" "custom_route" {
  name                   = var.route_name
  dest_range             = var.dest_range
  network                = var.network_name
  next_hop_instance      = var.next_hop_instance
  next_hop_instance_zone = var.next_hop_instance_zone
  priority               = var.priority
}
