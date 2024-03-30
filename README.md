# Sample Project on AWS

## Overview

This repository contains all the necessary code and documentation for setting up a sample project on AWS. Each week, new components will be added.

## Weekly Plan

### Week 1: Deploy Nexus Repository OSS on EC2

- Deploy Nexus Repository OSS on an EC2 instance.
- [Instructions and details](week1)

### Week 2: Deploy Ansible and use it to Configure Nexus

- Deploy Ansible on a new EC2 instance.
- Configure Nexus Repository using an Ansible playbook.
- [Instructions and details](week2)

### Week 3: Nexus & Splunk Automation with Ansible

- Configure Nexus by Ansible
- Configure Linux Instances to use the nexus repo
- Install Splunk
- [Instructions and details](week3)

### Week 4: Deploy Highly Available Splunk

- Deploy a highly available Splunk setup on EC2 instances using Terraform.

## Repository Structure

- `week1`: Nexus Repository deployment files.
- `week2`: Ansible playbooks and configuration files.
- `week3`: Update scripts, Linux OS configurations, and Splunk deployment files.
- `week4`: Terraform files for the Splunk setup.

## Prerequisites

Before you can use these configurations, you need to have the following:

- An AWS account with appropriate permissions to create resources such as VPC, EC2 instances, and security groups.
- Terraform installed on your local machine. [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).
- AWS CLI installed and configured on your local machine. [Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).
- Your AWS credentials, including your Access Key and Secret Access Key, are configured for use with the AWS CLI or Terraform. These credentials should be associated with a user who has the necessary permissions to deploy and manage the AWS resources.
To set up your AWS credentials:

    1. Log in to the AWS Management Console.
    2. Navigate to the IAM (Identity and Access Management) service.
    3. Create a new IAM user or use an existing one, and ensure programmatic access is enabled for the user.
    4. Attach policies that grant the user sufficient permissions to create, modify, and delete resources as required by the Terraform configurations.
    5. On the final screen, you will be provided with an Access Key ID and Secret Access Key for the user. Store these credentials securely.
    6. Configure the AWS CLI with the credentials by running `aws configure` and entering the Access Key ID and Secret Access Key when prompted.

## Usage

Follow the detailed instructions within each weekly folder for deployment steps.

## Contributing

Contributions to this project are welcome. Please fork the repository, make your changes, and submit a pull request.

## License

This project is open source and available under the [MIT License](LICENSE).

## Changelog


