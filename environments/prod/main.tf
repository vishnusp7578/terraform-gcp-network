module "vpc" {
  source       = "../../modules/vpc"
  project_id   = var.project_id
  region       = var.region
  vpc_name     = "prod-vpc"
  subnets      = var.subnets
}

module "compute" {
  source          = "../../modules/compute"
  project_id      = var.project_id
  vpc_id          = module.vpc.vpc_id
  subnet_links    = module.vpc.subnet_links
  machine_type    = "e2-micro"
}



