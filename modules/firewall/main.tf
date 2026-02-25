resource "google_compute_firewall" "ssh" {
  name    = "allow-ssh-from-ip"
  network = var.network

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = [var.admin_ip]
  target_tags   = ["ssh"]
}

resource "google_compute_firewall" "web" {
  name    = "allow-web"
  network = var.network

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web"]
}

resource "google_compute_firewall" "internal_icmp" {
  name    = "allow-internal-icmp"
  network = var.network

  allow {
    protocol = "icmp"
  }

  source_ranges = var.internal_ranges
}
