resource "aws_security_group" "web_sg" {
  name        = var.sg_name

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_ip]
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
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.web_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.instance_profile.name

  

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y docker.io docker-compose",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      "sudo apt-get install -y unzip jq",
      "curl -o awscliv2.zip https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip",
      "unzip awscliv2.zip",
      "sudo ./aws/install",
      "SECRET_NAME='my-test-secret'",
      "REGION='${var.aws_region}'",
      "SECRET_JSON=$(aws secretsmanager get-secret-value --secret-id \"$SECRET_NAME\" --region \"$REGION\")",
      "PASSWORD=$(echo \"$SECRET_JSON\" | jq -r '.SecretString' | jq -r '.password')",
      "echo \"SECRET_PASSWORD=$PASSWORD\" | sudo tee /home/ubuntu/.env",
      "sudo chmod 600 /home/ubuntu/.env",
      "sudo chown ubuntu:ubuntu /home/ubuntu/.env"
    ]
    connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }
}
