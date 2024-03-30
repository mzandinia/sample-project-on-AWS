module "ec2_splunk" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.0"

  depends_on = [module.vpc]

  create_spot_instance                = true
  spot_wait_for_fulfillment           = true
  spot_type                           = "persistent"
  spot_instance_interruption_behavior = "stop"

  name                        = "Splunk"
  ami                         = data.aws_ami.ubuntu-22.id
  instance_type               = var.instance_type[4]
  availability_zone           = element(module.vpc.azs, 0)
  subnet_id                   = element(module.vpc.private_subnets, 0)
  vpc_security_group_ids      = [data.aws_security_groups.default.ids[0]]
  private_ip                  = "10.10.101.31"
  associate_public_ip_address = false
  root_block_device = [
    {
      encrypted   = false
      volume_type = "gp3"
      volume_size = 30
    },
  ]
  user_data = file("${path.module}/config_linux_instances.sh")

  tags = local.common_tags

}

