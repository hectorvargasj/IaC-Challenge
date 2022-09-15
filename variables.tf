variable "vpc" {default = "0"}
variable "aws_region" {default = "us-east-1"}
variable "image" {default = "ami-05fa00d4c63e32376"}
variable "instance_type" {default = "t2.micro"}
variable "key_pair" {default = "test-key"}
variable "vol_size" {default = "30"}
variable "vpc_cidr" {default = "10.0.0.0/16"}
variable "subnet_cidr" {default = "10.0.0.0/24"}