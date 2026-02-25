resource "google_compute_instance" "router_vm" {
  name         = "var.router_vm"
  machine_type = "e2-medium" # Routing can be CPU intensive; avoid micro for this
  zone         = "${var.region}-a"

  #This allows the VM to process traffic destined for other IPs
  can_ip_forward = true 

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = var.subnet_links["subnet-a"] # Place it in your internal subnet
    # No access_config needed if it's purely internal
  }

  service_account {
    email  = var.vm_sa.email
    scopes = ["cloud-platform"]
  }
}
