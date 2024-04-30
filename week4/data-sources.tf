## VPC data sources
data "aws_availability_zones" "available" {}

## EC2 Instances data sources
data "aws_ami" "ubuntu-22" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  owners = ["099720109477"] # Canonical
}

data "aws_ami" "debian-12" {
  most_recent = true
  filter {
    name   = "name"
    values = ["debian-12-amd64*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

data "aws_ami" "almalinux-9" {
  most_recent = true
  filter {
    name   = "name"
    values = ["AlmaLinux OS 9*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

data "aws_ami" "rockylinux-9" {
  most_recent = true
  filter {
    name   = "name"
    values = ["Rocky-9-EC2-Base-9*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

## Security Group data sources

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
