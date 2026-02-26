variable "project_id" { type = string }
variable "region"     { type = string }
variable "vpc_name"   { type = string }

variable "subnets" {
  type = map(object({
    subnet_name = string
    subnet_ip = string
    subnet_region = string
    cidr = string
  }))
}


