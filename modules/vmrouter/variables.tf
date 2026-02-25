variable "project_id" {
  type        = string
  description = "The GCP project ID"
}

variable "region" {
  type        = string
  description = "The region for the router VM"
}

variable "subnet_links" {
  type        = map(string)
  description = "Map of subnet names to their self_links (from VPC module)"
}

variable "vm_sa_email" {
  type        = string
  description = "The email of the service account to attach to the router"
}
variable "vpc_id" {
  type        = string
  description = "The ID of the VPC network"
}
