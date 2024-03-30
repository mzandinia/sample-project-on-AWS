module "linux_instances" {
  depends_on = [module.vpc]
  source     = "terraform-aws-modules/ec2-instance/aws"
  version    = "5.6.0"

  for_each               = local.some_linux_distro
  name                   = each.key
  ami                    = each.value.ami
  instance_type          = each.value.instance_type
  availability_zone      = each.value.availability_zone
  subnet_id              = each.value.subnet_id
  private_ip             = each.value.ip
  vpc_security_group_ids = [data.aws_security_groups.default.ids[0]]
  enable_volume_tags     = false
  user_data              = file("${path.module}/config_linux_instances.sh")

  tags = local.common_tags
}
