variable "project_id" {
  type        = string
  description = "The GCP Project ID"
}

variable "region" {
  type        = string
  default     = "us-central1"
}

variable "subnets" {
  type = map(object({
    subnet_name   = string
    subnet_region = string
    cidr          = string
  }))
  description = "Must match the VPC module object schema"
}

variable "machine_type" {
  type    = string
  default = "e2-micro"
}

variable "vm_image" {
  type    = string
  default = "debian-cloud/debian-11"
}

variable "my_ip" {
  type        = string
  description = " public IP address"
}

variable "router_vm" {
  type        = string
  description = "The VM ID"
}






