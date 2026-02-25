output "internal_ips" {
  description = "The internal IP addresses of the instances"
  # We use a 'for' loop to iterate over the collection of instances
  value = {
    for instance in google_compute_instance.vm : 
    instance.name => instance.network_interface[0].network_ip
  }
}

