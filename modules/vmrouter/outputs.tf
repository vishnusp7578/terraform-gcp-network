output "router_vm" {
  value       = google_compute_instance.router_vm.name
  description = "The name of the router VM for use in static routes"
}
