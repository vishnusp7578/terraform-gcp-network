project_id   = "vishnu-eval"
region       = "us-central1"
machine_type = "e2-micro"
vm_image     = "debian-cloud/debian-11"
my_ip  = "0.0.0.0/0"
router_vm = "test-router"

subnets = {
  "subnet-a" = {
    subnet_name   = "subnet-a"
    subnet_region = "us-central1"
    cidr          = "10.0.1.0/24"
  }
  "subnet-b" = {
    subnet_name   = "subnet-b"
    subnet_region = "us-central1"
    cidr          = "10.0.2.0/24"
  }
}







