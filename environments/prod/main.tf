provider "google" {
  project = var.project_id
  region  = var.region
}

module "vpc" {
  source   = "../../modules/vpc"
  vpc_name = "custom-vpc"
  region   = var.region
  subnets  = var.subnets
}

module "firewall" {
  source          = "../../modules/firewall"
  network         = module.vpc.vpc_id
  admin_ip        = var.admin_ip
  internal_ranges = ["10.10.0.0/16"]
}

module "compute" {
  source = "../../modules/compute"

  instances = {
    vm-a = {
      zone   = "us-central1-a"
      subnet = module.vpc.subnet_ids["subnet-a"]
      tags   = ["ssh", "web"]
    }
    vm-b = {
      zone   = "us-central1-b"
      subnet = module.vpc.subnet_ids["subnet-b"]
      tags   = ["ssh"]
    }
  }

  sa_name = "vm-service-account"
}
