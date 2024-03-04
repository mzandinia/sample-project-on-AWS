# AWS Region
variable "aws_region" {
  description = "maps of regions"
  type        = map(string)

  default = {
    r1 = "us-east-1"    # North Virginia
    r2 = "us-east-2"    # Ohio
    r3 = "us-west-1"    # North California
    r4 = "us-west-2"    # Oregon
    r5 = "eu-west-1"    # Ireland
    r6 = "eu-west-2"    # London
    r7 = "eu-west-3"    # Paris
    r8 = "eu-central-1" # Frankfort
    r9 = "eu-north-1"   # Stockholm
  }
}

# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type        = string
  default     = "Dev"
}

# Business Division
variable "business_divsion" {
  description = "Business Division in the organization"
  type        = string
  default     = "Network"
}

variable "Contributors" {
  description = "A list of contributors"
  type        = list(string)
  default     = ["Majid"]
}

variable "Version" {
  description = "Version"
  type        = number
  default     = 1
}

# Define Local Values in Terraform
locals {
  region       = var.aws_region["r1"]
  owners       = var.business_divsion
  contributors = join(", ", var.Contributors)
  environment  = var.environment
  version      = var.Version
  name         = "${local.owners}-${local.version}"
  vpc_cidr     = "10.10.0.0/16"

  common_tags = {
    contributors = local.contributors
    owners       = local.owners
    environment  = local.environment
    version      = local.version
  }
}
