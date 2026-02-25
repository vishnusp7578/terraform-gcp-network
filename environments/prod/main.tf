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






