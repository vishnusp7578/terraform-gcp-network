resource "google_compute_network" "vpc" {
  name    = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
 for_each      = var.subnets
  name          = each.value.subnet_name  
  ip_cidr_range = each.value.cidr       
  region        = each.value.subnet_region 
  network       = google_compute_network.vpc.id
  lifecycle {
    ignore_changes = all
  }
}

# Firewall rule to allow internal communication (Ping/ICMP)
resource "google_compute_firewall" "allow_internal" {
  name    = "${var.vpc_name}-allow-internal"
  network = google_compute_network.vpc.name

  allow {
    protocol = "icmp"
  }

  source_ranges = [for s in google_compute_subnetwork.subnet : s.ip_cidr_range]
}





