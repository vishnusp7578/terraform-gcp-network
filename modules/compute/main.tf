# This name "sa" must match the reference below
resource "google_service_account" "sa" {
  account_id   = "${var.name}-sa"
  display_name = "Service Account for ${var.name}"
}

resource "google_compute_instance" "vm" {
  name         = var.name
  machine_type = var.machine_type # Use the variable passed from root
  zone         = var.zone
  tags         = var.tags

  boot_disk {
    initialize_params {
      image = var.vm_image # Use the variable passed from root
    }
  }

  network_interface {
    subnetwork = var.subnet_id
    access_config {}
  }

  service_account {
    # This must match the resource block name above
    email  = google_service_account.sa.email 
    scopes = ["cloud-platform"]
  }
}

