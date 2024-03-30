module "ec2_nexus" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.0"

  depends_on = [module.vpc]

  create_spot_instance                = true
  spot_wait_for_fulfillment           = true
  spot_type                           = "persistent"
  spot_instance_interruption_behavior = "stop"

  name                        = "ec2-public-nexus"
  ami                         = data.aws_ami.ubuntu-22.id
  instance_type               = var.instance_type[1]
  availability_zone           = element(module.vpc.azs, 0)
  subnet_id                   = element(module.vpc.public_subnets, 0)
  vpc_security_group_ids      = [module.nexus_sg.security_group_id, data.aws_security_groups.default.ids[0]]
  private_ip                  = "10.10.10.10"
  associate_public_ip_address = true
  root_block_device = [
    {
      encrypted   = false
      volume_type = "gp3"
      volume_size = var.nexus_volume_size
    },
  ]
  user_data = file("${path.module}/config_nexus.sh")

  tags = local.common_tags

}

resource "null_resource" "instance_config" {
  # Makes sure this resource is created after the EC2 instance from the module
  depends_on = [module.ec2_nexus]

  # Trigger a change when the instance id changes
  triggers = {
    instance_id = module.ec2_nexus.id
  }

  provisioner "remote-exec" {
    # Connection details to the EC2 instance
    connection {
      type     = "ssh"
      user     = "ubuntu"
      password = "changeme"
      host     = module.ec2_nexus.public_ip
      timeout  = "30s"
    }

    # The script you want to run on the instance
    inline = [
      "sleep 300", # Wait a bit to allow Nexus to initialize and create the admin.password file
      "nexus_pass=$(sudo docker exec nexus cat /nexus-data/admin.password)",
      "echo Nexus initial password: $nexus_pass"
    ]
  }
}
