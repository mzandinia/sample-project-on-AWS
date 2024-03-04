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

  owners = ["099720109477"] # Canonical
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = list(string)
  default     = ["t3.micro", "t3.medium", "c5.xlarge", "c5.2xlarge", "c5.4xlarge"]
}

variable "nexus_volume_size" {
  description = "The volume size of Nexus"
  type        = number
  default     = 30
}
