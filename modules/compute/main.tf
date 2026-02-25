resource "google_service_account" "vm_sa" {
  account_id   = "vm-internal-sa"
  display_name = "Custom VM Service Account"
}

resource "google_compute_instance" "vm" {
  for_each     = var.subnet_links
  name         = "vm-${each.key}"
  machine_type = var.machine_type
  zone         = "${var.region}-${substr(each.key, -1, 1)}" # Dynamic zone mapping

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = each.value
    # Omitting access_config block makes the VM private (internal only)
  }

  service_account {
    email  = google_service_account.vm_sa.email
    scopes = ["cloud-platform"]
  }
}



