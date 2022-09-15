terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~> 4.16"
      }
    }
    required_version = ">= 1.1.4"
}

terraform {
  cloud {
    organization = "hvargas"

    workspaces {
      name = "example-workspace"
    }
  }
}

provider "aws"{  
  region                    = var.aws_region
}

################### VPC #####################
################### Subnet #####################

module "vpc" {
  source            = "./modules/vpc"
  vpc_cidr          = var.vpc_cidr
  subnet_cidr       = var.subnet_cidr
}


################### Security Group #####################

resource "aws_security_group" "IaC_sg" {
  name        = "IaC_sg"
  description = "Security group for the IaC challenge"
  vpc_id      =  module.vpc.vpc_id

  ingress {
    description      = "HTTP access"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "SSH access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "IaC_sg"
  }
}

################### Route Table #########################
resource "aws_route_table" "IaC-route" {
  vpc_id = module.vpc.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IaC-gw.id
  }

  tags = {
    Name = "IaC-route"
  }
}

################### Table association ####################

resource "aws_route_table_association" "a" {
  subnet_id      = module.vpc.subnet_id
  route_table_id = aws_route_table.IaC-route.id
}


################### Internet Gateway #####################

resource "aws_internet_gateway" "IaC-gw" {
  vpc_id = module.vpc.vpc_id

  tags = {
    Name = "IaC-gw"
  }
}

################### Instance #####################
module "ec2_instance" {
  source                 = "./modules/ec2_instance"
  image                  = var.image
  instance_type          = var.instance_type
  key_pair               = var.key_pair
  security_groups        = [aws_security_group.IaC_sg.id]
  subnet_id              = module.vpc.subnet_id
}