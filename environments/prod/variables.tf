variable "project_id"    { type = string }
variable "region"        { type = string }
variable "network_name"  { type = string }
variable "my_ip"         { type = string } # From Cloud Build
variable "subnet_config" {
  type = map(object({ cidr = string }))
}
