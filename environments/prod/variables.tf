variable "machine_type" {
  type        = string
  description = "The size of the VM"
}

variable "vm_image" {
  type        = string
  description = "The OS image for the VM"
}

variable "subnet_config" {
  description = "A map of subnet names to their CIDR blocks"
  type = map(object({
    cidr = string
  }))
}

variable "region" {
  type        = string
  description = "The GCP region where resources will be created"
}

variable "my_ip" {
  type        = string
  description = "The public IP address allowed to SSH into the VMs, passed from the CI/CD pipeline."
}

