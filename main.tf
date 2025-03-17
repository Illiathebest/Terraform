provider "aws" { 
  region = var.aws_region
}

data "aws_caller_identity" "current" {}

module "web_instance" {
  source = "./modules/web-instance"
  
  aws_region       = var.aws_region
  ami_id           = var.ami_id
  instance_type    = var.instance_type
  key_name         = var.key_name
  allowed_ssh_ip   = var.allowed_ssh_ip
  ssh_user         = var.ssh_user
  private_key_path = var.private_key_path
  sg_name          = "web_sg"
}
