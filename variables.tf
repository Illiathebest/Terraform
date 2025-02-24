variable "aws_region" {
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  type        = string
  default     = "ami-04b4f1a9cf54c11d0"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  type        = string
  default     = "devops"
}

variable "allowed_ssh_ip" {
  type        = string
  default     = "176.102.39.212/32"
}

variable "ssh_user" {
  type        = string
  default     = "ubuntu"
}

variable "private_key_path" {
  type        = string
  default     = "C:/Users/kukha/Terraform/devops.pem"
}

variable "secret_name" {
  type        = string
  default     = "my-test-secret"
}
