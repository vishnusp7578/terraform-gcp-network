# Project-level configuration
project_id   = "vishnu-eval"
region       = "us-central1"

# VPC Configuration
# These values are passed into the VPC module
network_name = "production-vpc"

subnet_config = {
  "us-central1-a-subnet" = {
    cidr = "10.0.1.0/24"
  },
  "us-central1-b-subnet" = {
    cidr = "10.0.2.0/24"
  }
}

# VM Configuration
machine_type = "e2-micro"
vm_image     = "debian-cloud/debian-11"
