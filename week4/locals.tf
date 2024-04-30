## Define local variables
locals {
  region       = var.aws_region["r1"]
  owners       = var.business_divsion
  contributors = join(", ", var.Contributors)
  environment  = var.environment
  version      = var.Version
  name         = "${local.owners}-${local.version}"

  common_tags = {
    contributors = local.contributors
    owners       = local.owners
    environment  = local.environment
    version      = local.version
  }

  ## EC2 Instance module locals
  some_linux_distro = {

    ubuntu22 = {
      instance_type     = var.instance_type[2]
      ami               = "ami-0c7217cdde317cfec"
      availability_zone = element(module.vpc.azs, 0)
      subnet_id         = element(module.vpc.private_subnets, 0)
      cidr_blocks       = element(module.vpc.private_subnets_cidr_blocks, 0)
      ip                = "10.10.101.21"
      tags = {
        "Name" = "Ubuntu 22"
      }
    }

    debian12 = {
      instance_type     = var.instance_type[2]
      ami               = "ami-058bd2d568351da34"
      availability_zone = element(module.vpc.azs, 0)
      subnet_id         = element(module.vpc.private_subnets, 0)
      cidr_blocks       = element(module.vpc.private_subnets_cidr_blocks, 0)
      ip                = "10.10.101.22"
      tags = {
        "Name" = "Debian 12"
      }

    }

    almalinux9 = {
      instance_type     = var.instance_type[2]
      ami               = "ami-07bc349330a94a4e3"
      availability_zone = element(module.vpc.azs, 0)
      subnet_id         = element(module.vpc.private_subnets, 0)
      cidr_blocks       = element(module.vpc.private_subnets_cidr_blocks, 0)
      ip                = "10.10.101.23"
      tags = {
        "Name" = "Alma Linux 9"
      }
    }

    rockylinux9 = {
      instance_type     = var.instance_type[3]
      ami               = "ami-08f362c39d03a4eb5"
      availability_zone = element(module.vpc.azs, 0)
      subnet_id         = element(module.vpc.private_subnets, 0)
      cidr_blocks       = element(module.vpc.private_subnets_cidr_blocks, 0)
      ip                = "10.10.101.24"
      tags = {
        "Name" = "Rocky Linux 9"
      }
    }

    amzonlinux = {
      instance_type     = var.instance_type[2]
      ami               = "ami-051f8a213df8bc089"
      availability_zone = element(module.vpc.azs, 0)
      subnet_id         = element(module.vpc.private_subnets, 0)
      cidr_blocks       = element(module.vpc.private_subnets_cidr_blocks, 0)
      ip                = "10.10.101.25"
      tags = {
        "Name" = "Amazon Linux 2023"
      }
    }
  }

}

