provider "aws" {
  region = var.aws_region

  skip_credentials_validation = var.offline_validation
  skip_requesting_account_id  = var.offline_validation
  skip_metadata_api_check     = var.offline_validation
  skip_region_validation      = var.offline_validation
}

resource "aws_security_group" "web_sg" {
  name        = "cicd-demo-web-sg"
  description = "Allow SSH and HTTP"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_cidr]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cicd-demo-web-sg"
  }
}

resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOT
    #!/bin/bash
    yum install -y nginx
    systemctl enable --now nginx
  EOT

  tags = {
    Name    = "cicd-demo-instance"
    Owner   = "Aditya Ubale"
    PRN     = "202301040111"
    Project = "Jenkins-Terraform-Activity2"
  }
}
