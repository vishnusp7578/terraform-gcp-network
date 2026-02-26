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

# --- VPC A ---
module "vpc_a" {
  source     = "../../modules/vpc"
  project_id = var.project_id
  vpc_name   = "network-a"
  region     = var.region
  
  # CHANGED: Using { } for a map instead of [ ] for a list
  subnets = {
    "subnet-a" = {
      subnet_name   = "subnet-a"
      subnet_ip     = "10.1.0.0/24"
      subnet_region = var.region
    }
  }
}

# --- VPC B ---
module "vpc_b" {
  source     = "../../modules/vpc"
  project_id = var.project_id
  vpc_name   = "network-b"
  region     = var.region

  # CHANGED: Using { } for a map
  subnets = {
    "subnet-b" = {
      subnet_name   = "subnet-b"
      subnet_ip     = "10.2.0.0/24"
      subnet_region = var.region
    }
  }
}

# --- Peering ---
module "vpc_peering" {
  source     = "../../modules/peering"
  vpc_a_id   = module.vpc_a.vpc_id
  vpc_a_name = module.vpc_a.vpc_name
  vpc_b_id   = module.vpc_b.vpc_id
  vpc_b_name = module.vpc_b.vpc_name
}
# --- Firewall Rule for VPC A (Allow traffic from VPC B) ---
resource "google_compute_firewall" "allow_peer_b" {
  name    = "allow-traffic-from-b"
  network = module.vpc_a.vpc_name

  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }

  source_ranges = [module.vpc_b.subnets["subnet-b"].ip_cidr_range]
}

# --- Firewall Rule for VPC B (Allow traffic from VPC A) ---
resource "google_compute_firewall" "allow_peer_a" {
  name    = "allow-traffic-from-a"
  network = module.vpc_b.vpc_name

  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }

  source_ranges = [module.vpc_a.subnets["subnet-a"].ip_cidr_range]
}




















