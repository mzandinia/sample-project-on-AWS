locals {

  some_linux_distro = {
    ubuntu22 = {
      instance_type = var.instance_type[2]
      # ami               = data.aws_ami.ubuntu-22.id
      ami               = "ami-0c7217cdde317cfec"
      availability_zone = element(module.vpc.azs, 0)
      subnet_id         = element(module.vpc.private_subnets, 0)
      cidr_blocks       = element(module.vpc.private_subnets_cidr_blocks, 0)
      ip                = "10.10.101.21"
      tags = {
        "Name" = "ubuntu22"
      }
    }

    debian12 = {
      instance_type = var.instance_type[2]
      # ami               = data.aws_ami.debian-12.id
      ami               = "ami-058bd2d568351da34"
      availability_zone = element(module.vpc.azs, 0)
      subnet_id         = element(module.vpc.private_subnets, 0)
      cidr_blocks       = element(module.vpc.private_subnets_cidr_blocks, 0)
      ip                = "10.10.101.22"
      tags = {
        "Name" = "debian12"
      }

    }

    almalinux9 = {
      instance_type = var.instance_type[2]
      # ami               = data.aws_ami.almalinux-9.id
      ami               = "ami-07bc349330a94a4e3"
      availability_zone = element(module.vpc.azs, 0)
      subnet_id         = element(module.vpc.private_subnets, 0)
      cidr_blocks       = element(module.vpc.private_subnets_cidr_blocks, 0)
      ip                = "10.10.101.23"
      tags = {
        "Name" = "almalinux9"
      }
    }

    rockylinux9 = {
      instance_type = var.instance_type[3]
      # ami               = data.aws_ami.rockylinux-9.id
      ami               = "ami-08f362c39d03a4eb5"
      availability_zone = element(module.vpc.azs, 0)
      subnet_id         = element(module.vpc.private_subnets, 0)
      cidr_blocks       = element(module.vpc.private_subnets_cidr_blocks, 0)
      ip                = "10.10.101.24"
      tags = {
        "Name" = "rockylinux9"
      }
    }
  }
}
