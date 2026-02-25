resource "google_service_account" "vm_sa" {
  account_id   = var.sa_name
  display_name = "VM Service Account"
}

resource "google_compute_instance" "vm" {
  for_each = var.instances

  name         = each.key
  machine_type = "e2-medium"
  zone         = each.value.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork = each.value.subnet
    access_config {} # ephemeral external IP
  }

  service_account {
    email  = google_service_account.vm_sa.email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  tags = each.value.tags

  metadata = {
    enable-oslogin = "TRUE"
  }

  shielded_instance_config {
    enable_secure_boot = true
  }
}
