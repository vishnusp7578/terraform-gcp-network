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



