module "alb" {
  source = "terraform-aws-modules/alb/aws"

  name    = "splunk-alb"
  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.public_subnets

  enable_deletion_protection = false

  security_groups       = [module.alb_sg.security_group_id]
  create_security_group = false

  listeners = {

    splunk-target = {
      port     = 80
      protocol = "HTTP"
      forward = {
        target_group_key = "splunk-instance"
      }
    }
  }

  target_groups = {
    splunk-instance = {
      name_prefix                       = "sp-tg-"
      protocol                          = "HTTP"
      port                              = 80
      target_type                       = "instance"
      load_balancing_cross_zone_enabled = false

      health_check = {
        enabled             = true
        interval            = 30
        path                = "/en-US/account/login?return_to=%2Fen-US%2F"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
      }

      protocol_version = "HTTP1"
      target_id        = module.ec2_splunk.spot_instance_id
      port             = 8000

    }
  }

}


