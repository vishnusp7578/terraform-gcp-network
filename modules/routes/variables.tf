variable "route_name" {
  type = string
}

variable "dest_range" {
  type = string
}

variable "network_name" {
  type = string
}

variable "next_hop_instance" {
  type = string
}

variable "next_hop_instance_zone" {
  type = string
}

variable "priority" {
  type    = number
  default = 1000
}
