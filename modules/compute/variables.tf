variable "project_id"   { type = string }
variable "vpc_id"       { type = string }
variable "machine_type" { type = string }

variable "subnet_links" {
  description = "Map of subnet names to their self_links"
  type        = map(string)
}

variable "region" {
  type    = string
  default = "us-central1"
}


