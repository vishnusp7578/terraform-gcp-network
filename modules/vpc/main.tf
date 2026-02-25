resource "google_compute_network" "main" {
  name                    = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnets" {
  for_each      = var.subnet_config
  name          = each.key
  ip_cidr_range = each.value.cidr
  region        = var.region
  network       = google_compute_network.main.id
  private_ip_google_access = true
}

output "network_id" { value = google_compute_network.main.id }
output "subnet_ids" { value = { for k, v in google_compute_subnetwork.subnets : k => v.id } }
