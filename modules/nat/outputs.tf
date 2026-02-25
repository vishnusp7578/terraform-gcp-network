module "nat" {
  source           = "../../modules/nat"
  project_id       = var.project_id
  region           = var.region
  vpc_id           = module.vpc.vpc_id
  network_name     = module.vpc.vpc_name
  
  # PASS ONLY ONE SUBNET:
  # Assuming your VPC module output is: subnet_links = { "subnet-a" = "...", "subnet-b" = "..." }
  target_subnet_id = module.vpc.subnet_links["subnet-a"]
}
