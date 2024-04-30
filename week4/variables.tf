## Generic variables

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
  description = "The version of the project"
  type        = number
  default     = 1
}


## VPC Variables

variable "vpc_name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = "Dev-Test"
}

variable "vpc_cidr_block" {
  description = "VPC CIDR Block"
  type        = string
  default     = "10.10.0.0/16"
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = ["10.10.10.0/24", "10.10.11.0/24"]
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = ["10.10.101.0/24", "10.10.102.0/24", "10.10.103.0/24"]
}

## EC2 Instances variables

variable "instance_type" {
  description = "The type of instance to start"
  type        = list(string)
  default     = ["t3.micro", "t3.medium", "t2.micro", "t2.small", "c5.xlarge", "c5.2xlarge", "c5.4xlarge"]
}

variable "nexus_volume_size" {
  description = "The volume size of Nexus"
  type        = number
  default     = 15
}

## Security Groups variables

variable "ip_to_open" {
  description = "The public ip that you want to open the security group"
  type        = string
  default     = "0.0.0.0/0"
}
