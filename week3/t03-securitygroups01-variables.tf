data "aws_security_groups" "default" {

  filter {
    name   = "group-name"
    values = ["default"]
  }

  filter {
    name   = "vpc-id"
    values = [module.vpc.vpc_id]
  }
}

variable "ip_to_open" {
  description = "The public ip that you want to open the security group"
  type        = string
  default     = "0.0.0.0/0"
}
