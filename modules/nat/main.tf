resource "google_compute_router" "router" {
  name    = "${var.network_name}-router"
  region  = var.region
  network = var.vpc_id
}

resource "google_compute_router_nat" "nat" {
  name                               = "${var.network_name}-nat"
  router                             = google_compute_router.router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"

  
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    # The self_link or ID of the specific subnet
    name                    = var.target_subnet_id 
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}
