resource "aws_vpc" "IaC_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "IaC_vpc"
  }
}

resource "aws_subnet" "IaC_public_subnet" {
  vpc_id     = aws_vpc.IaC_vpc.id
  cidr_block = var.subnet_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "IaC_public_subnet"
  }
}