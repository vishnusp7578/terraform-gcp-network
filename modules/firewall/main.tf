resource "google_compute_firewall" "ssh" {
  name    = "allow-ssh"
  network = var.network_id
  allow { protocol = "tcp"; ports = ["22"] }
  source_ranges = [var.admin_ip]
  target_tags   = ["ssh-enabled"]
}

resource "google_compute_firewall" "http" {
  name    = "allow-web"
  network = var.network_id
  allow { protocol = "tcp"; ports = ["80", "443"] }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web-server"]
}

# Explicitly allow internal ICMP (Ping)
resource "google_compute_firewall" "internal_ping" {
  name    = "allow-internal-ping"
  network = var.network_id
  allow { protocol = "icmp" }
  source_ranges = ["10.0.0.0/16"] 
}
