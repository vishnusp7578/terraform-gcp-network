module "vpc" {
  source       = "../../modules/vpc"
  network_name = "prod-vpc"
  region       = "us-central1"
  subnet_config = {
    "subnet-a" = { cidr = "10.0.1.0/24" }
    "subnet-b" = { cidr = "10.0.2.0/24" }
  }
}

module "firewall" {
  source     = "../../modules/firewall"
  network_id = module.vpc.network_id
  admin_ip   = var.my_ip
}

module "vm_a" {
  source    = "../../modules/compute"
  name      = "vm-a"
  zone      = "us-central1-a"
  subnet_id = module.vpc.subnet_ids["subnet-a"]
  tags      = ["ssh-enabled", "web-server"]
}

module "vm_b" {
  source    = "../../modules/compute"
  name      = "vm-b"
  zone      = "us-central1-b"
  subnet_id = module.vpc.subnet_ids["subnet-b"]
  tags      = ["ssh-enabled"]
}

