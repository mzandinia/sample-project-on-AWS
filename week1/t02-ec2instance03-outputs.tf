output "Nexus-login-address" {
  description = "The public IP address assigned to the instance, if applicable. NOTE: If you are using an aws_eip with your instance, you should refer to the EIP's address directly and not use `public_ip` as this field will change after the EIP is attached"
  value       = "http://${module.ec2_nexus.public_ip}:8081"
}

