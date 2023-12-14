terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow-ssh-from-anywhere"
  description = "Allow SSH inbound "

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_https_outbound" {
  name        = "allow-https-outbound"
  description = "Allow outbound HTTPS traffic"

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow traffic to any destination on port 443
  }
}

resource "aws_security_group" "allow_http_outbound" {
  name        = "allow-http-outbound"
  description = "Allow outbound HTTP traffic"

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow traffic to any destination on port 80
  }
}

resource "aws_security_group" "allow_http_inbound_backend" {
  name        = "allow-http-inbound-backend-from-anywhere"
  description = "Allow http inbound for backend port 5000"

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_http_inbound_frontend" {
  name        = "allow-http-inbound-frontend-from-anywhere"
  description = "Allow http inbound for frontend port 3000"

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "fullStack" {
    ami = "ami-0fc5d935ebf8bc3bc"
    instance_type = "t2.micro"
    key_name = "fullstack"
    user_data = file("deployment.sh")
    security_groups = [aws_security_group.allow_ssh.name, aws_security_group.allow_https_outbound.name, aws_security_group.allow_http_outbound.name, aws_security_group.allow_http_inbound_backend.name, aws_security_group.allow_http_inbound_frontend.name]
    tags = {
    Name  = "fullStackDocker"
  }
}