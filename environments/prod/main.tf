module "vpc" {
  source     = "../../modules/vpc"
  project_id = var.project_id
  region     = var.region
  vpc_name   = "prod-vpc"
  subnets    = var.subnets
}

module "compute" {
  source       = "../../modules/compute"
  project_id   = var.project_id
  region       = var.region
  vpc_id       = module.vpc.vpc_id
  subnet_links = module.vpc.subnet_links
  machine_type = var.machine_type
  # If your compute module has a vm_image variable, add it here:
  # vm_image   = var.vm_image 
}

module "firewall" {
  source       = "../../modules/firewall"
  project_id   = var.project_id
  network_name = module.vpc.vpc_name      # Output from VPC module
  my_ip        = var.my_ip               # From your variables.tf
  vm_sa_email  = module.compute.vm_sa_email # Output from Compute module
}

module "routervm" {
  source       = "../../modules/vmrouter"
  project_id   = var.project_id
  region       = var.region
  vpc_id       = module.vpc.vpc_id
  subnet_links = module.vpc.subnet_links
  machine_type = var.machine_type
  vm_sa_email  = module.compute.vm_sa_email 
  router_vm = var.router_vm
}

module "lab_route" {
  source                 = "../../modules/routes"
  route_name             = "route-to-lab-vpn"
  dest_range             = "10.50.0.0/16"
  network_name           = module.vpc.vpc_name
  next_hop_instance      = module.routervm.router_vm
  next_hop_instance_zone = "${var.region}-a"
  priority               = 1000
}

module "test_na" {
  source           = "../../modules/nat"
  project_id       = var.project_id
  region           = var.region
  vpc_id           = module.vpc.vpc_id
  network_name     = module.vpc.vpc_name
  target_subnet_id = module.vpc.subnet_links["subnet-a"]
}
















