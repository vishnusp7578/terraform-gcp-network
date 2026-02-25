variable "project_id" {
  type        = string
  description = "The GCP project ID"
}

variable "network_name" {
  type        = string
  description = "The name of the VPC network where rules will be applied"
}

variable "my_ip" {
  type        = string
  description = "The public IP address (CIDR format) allowed to SSH into the VMs"
}

variable "vm_sa_email" {
  type        = string
  description = "The email of the service account used by the VMs (for identity-based firewalling)"
}
