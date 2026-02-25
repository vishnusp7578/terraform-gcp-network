variable "network_name" { type = string }
variable "region"       { type = string }
variable "subnet_config" {
  type = map(object({
    cidr = string
  }))
}
