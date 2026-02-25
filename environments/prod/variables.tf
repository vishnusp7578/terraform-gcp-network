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
