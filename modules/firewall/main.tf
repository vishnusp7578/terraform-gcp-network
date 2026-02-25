resource "google_compute_firewall" "ssh" {
  name    = "allow-ssh"
  network = var.network_id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = [var.admin_ip]
  target_tags   = ["ssh-enabled"]
}

resource "google_compute_firewall" "icmp" {
  name    = "allow-internal-icmp"
  network = var.network_id

  allow {
    protocol = "icmp"
  }

  source_ranges = ["10.0.0.0/16"] 
}
