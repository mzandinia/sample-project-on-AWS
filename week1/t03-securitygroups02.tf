## AWS EC2 Security Group Terraform Module

module "nexus_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "nexus-sg"
  description = "Allow SSH and TCP 8081 from everywhere"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      rule        = "ssh-tcp"
      cidr_blocks = "${module.vpc.vpc_cidr_block},${var.ip_to_open}"
    },
    {
      from_port   = 8081
      to_port     = 8081
      protocol    = "tcp"
      description = "The default Nexus port"
      cidr_blocks = "${module.vpc.vpc_cidr_block},${var.ip_to_open}"
    }
  ]

  # Egress Rule - all-all open
  egress_rules = ["all-all"]

  tags = local.common_tags
}

