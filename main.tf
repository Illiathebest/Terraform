provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Security group for web server instance"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["176.102.39.212/32"] 
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami           = "ami-04b4f1a9cf54c11d0" 
  instance_type = "t2.micro"
  key_name      = "devops"

  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y docker.io docker-compose",
      "sudo systemctl start docker",
      "sudo systemctl enable docker"
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu" 
      private_key = file("C:/Users/kukha/Terraform/devops.pem")
      host        = self.public_ip
    }
  }
}

output "instance_public_ip" {
  value = aws_instance.web.public_ip
}
