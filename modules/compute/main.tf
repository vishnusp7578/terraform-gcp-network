resource "google_compute_instance" "vm" {
  name         = var.name
  machine_type = "e2-micro"
  zone         = var.zone
  tags         = var.tags

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = var.subnet_id
    access_config {
      # Leaving this empty assigns an ephemeral external IP
    }
  }

  service_account {
    email  = google_service_account.sa.email
    scopes = ["cloud-platform"]
  }
}
