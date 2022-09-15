output "vpc_id" {
  value = module.vpc.vpc_id
}

output "IaC_ec2_id" {
  value = module.ec2_instance.IaC_ec2_id
}