output "vpc_id" {
  value = aws_vpc.IaC_vpc.id
}

output "subnet_id" {
  value = aws_subnet.IaC_public_subnet.id
}
