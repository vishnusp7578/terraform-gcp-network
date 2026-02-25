project_id   = "vishnu-eval"
region       = "us-central1"
machine_type = "e2-micro"
vm_image     = "debian-cloud/debian-11"
my_ip  = "103.203.72.155"

subnets = {
  "subnet-a" = { cidr = "10.0.1.0/24" }
  "subnet-b" = { cidr = "10.0.2.0/24" }
}




