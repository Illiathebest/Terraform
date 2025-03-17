variable "ami_id" {
  type        = string
}

variable "instance_type" {
  type        = string
}

variable "key_name" {
  type        = string
}

variable "allowed_ssh_ip" {
  type        = string
}

variable "ssh_user" {
  type        = string
}

variable "private_key_path" {
  type        = string
}

variable "sg_name" {
  type        = string
  default     = "web_sg"
}

variable "aws_region" {
  type        = string
}
