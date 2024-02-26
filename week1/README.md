# Week 1: Deploy Nexus Repository OSS on EC2

This repository contains Terraform configurations and scripts to deploy Nexus Repository Manager on an AWS EC2 instance within a custom VPC.

## Disclaimer

**Important: This repository is intended for test development purposes only. It is not recommended to use this setup in a production environment due to security concerns. Specifically, the configuration script utilizes plain text passwords, and the current EC2 setup does not enforce the use of key pairs for SSH access. Before using this project in a production environment, you must modify it.**

## Overview

Nexus Repository Manager is a free and open-source repository manager that enables you to manage artifacts required for development. This project automates the setup of Nexus on AWS, ensuring that the repository manager is readily available for use.

## Repository Structure

- `config_nexus.sh`: Bash script for configuring Nexus on the EC2 instance after deployment.
    - For simplicity, the script allows password authentication to log into the EC2 instance.
    - Nexus Repository is installed using Docker. The script pulls the official Sonatype Nexus image from the Docker Hub and configures it to run on the EC2 instance. Using Docker simplifies the installation and management of Nexus and ensures consistency across different environments.
- `t00-generic-variables.tf`: Terraform file containing generic variables for the setup.
- `t00-main.tf`: Main Terraform configuration file that sets up the AWS provider and calls other modules.
- `t01-vpc01-data-variables.tf`: Variable definitions for the VPC configuration.
- `t01-vpc02-module.tf`: Terraform module that sets up the VPC.
- `t02-ec2instance01-data-variables.tf`: Data variables for the EC2 instance.
- `t02-ec2instance02-nexus-host.tf`: Terraform configuration for deploying the EC2 instance that will host Nexus.
- `t02-ec2instance03-outputs.tf`: Output definitions for the EC2 instance deployment.
- `t03-securitygroups01-variables.tf`: Variable definitions for the security groups.
- `t03-securitygroups02.tf`: Terraform configuration for security groups.

## Variables

The Terraform configuration files use variables to allow for customization and to make the code more reusable. Below is an explanation of each variable file and its purpose:

- `t00-generic-variables.tf`: This file contains variables that are common across the Terraform configuration, such as the AWS region and availability zones. These are used throughout the Terraform files to configure resources consistently.
    - **Note: you can change the region in locals-region

- `t01-vpc01-data-variables.tf`: Defines variables specific to the VPC configuration, such as the CIDR block for the VPC and subnets. Adjust these to fit the network design that you require for your Nexus Repository. Also Contains AZ Data Source

- `t02-ec2instance01-data-variables.tf`: Contains data source and variables for the Nexus instance. You can config 'instance type' and 'volume size' for Nexus instance. Additionally, dynamically select the latest AMI ID for Ubuntu 22.04 in the specified AWS region.

- `t03-securitygroups01-variables.tf`: Holds variables related to security groups. you can specify which inbound IP addresses are permitted to access. Default behavior is everywhere.

## Usage

To deploy Nexus on an EC2 instance using this project, follow these steps:

1. Clone the repository to your local machine.
2. Run `terraform init` to initialize the Terraform working directory.
3. Run `terraform plan` to preview the changes that Terraform will make to your AWS infrastructure.
4. If the plan looks good, run `terraform apply` to apply the changes and deploy Nexus on EC2.

**Note: You can see the initial password of Nexus Repository at the end. Also you can find the URL that you can use to login into Nexus Repository.**

## Customization

You can customize your deployment by modifying the `.tf` files with your desired configurations. Ensure you review and update the variables to match your requirements.

## Security Notice

Ensure that your AWS credentials are securely stored and that you follow the principle of least privilege when setting up your Terraform AWS provider.

## Contributions

Contributions to this project are welcome. Please fork the repository, make your changes, and submit a pull request.

## License

This project is open source and available under the [MIT License](LICENSE).
