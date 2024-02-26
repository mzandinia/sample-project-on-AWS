#VPC Terraform Module

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.5.0"

  name = var.vpc_name
  cidr = var.vpc_cidr_block

  azs             = slice(data.aws_availability_zones.available.names, 0, 3)
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  # VPC DNS Parameters
  enable_dns_hostnames = true
  enable_dns_support   = true

  # VPC NAT Gateway
  enable_nat_gateway = false
  single_nat_gateway = false

  vpc_tags = {
    owners = local.owners
  }

  # Additional Tags to Subnets
  public_subnet_tags = {
    Type = "Public Subnets"
  }

  private_subnet_tags = {
    Type = "Private Subnets"
  }
}
