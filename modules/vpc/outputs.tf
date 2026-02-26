output "vpc_id" {
  value = google_compute_network.vpc.id
}

/* 
output "subnet_links" {
  value = { for k, v in google_compute_subnetwork.subnet : k => v.self_link }
}
*/
output "subnets" {
  value = google_compute_subnetwork.subnet
}

output "vpc_name" {
  value       = google_compute_network.vpc.name
  description = "The name of the VPC"
}

