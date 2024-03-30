# Week 3: Nexus & Splunk Automation with Ansible

This week's project involves automating the setup of a Nexus repository, proxying the Splunk download URL, configuring Linux instances, and installing Splunk using Ansible. **All resources from week 1 will be replaced, so ensure that you run terraform destroy to clean up before starting.**

## Disclaimer

**Important: This repository is intended for test development purposes only. It is not recommended to use this setup in a production environment due to security concerns. Specifically, the configuration script utilizes plain text passwords, and the current EC2 setup does not enforce the use of key pairs for SSH access. Before using this project in a production environment, you must modify it.**

## Overview

In this phase of the project, we focus on configuring Linux instances to use Nexus repository, and installing Splunk using Ansible playbook. Also because we created Splunk in the private subnet so we take advantage of nexus to get the Splunk installation file.

## Repository Structure

- `ansible-project/`: Contains 3 different playbooks and roles to configure the Nexus repository, Linux instances, and install Splunk.
- `Terrafom files`: contains necessary files for creating resources on AWS
  - `t00`: Basic variables and configurations of Terraform
  - `t01`: VPC configuration and variables
  - `t02`: all different instances, as well as variables, locals, and data sources
  - `t03`: all files that is necessary for creating security groups
- `bash shells files`: contains shell scripts that run on the boot procedure

## Usage

### Prerequisites

Before you can use these configurations, you need to have the following:

- An AWS account with appropriate permissions to create resources such as VPC, EC2 instances, and security groups.
- Terraform installed on your local machine. [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).
- AWS CLI installed and configured on your local machine. [Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).
- Your AWS credentials, including your Access Key and Secret Access Key, are configured for use with the AWS CLI or Terraform. These credentials should be associated with a user who has the necessary permissions to deploy and manage the AWS resources.

### Setting Up AWS Credentials

1. Log in to the AWS Management Console.
2. Navigate to the IAM (Identity and Access Management) service.
3. Create a new IAM user or use an existing one, and ensure programmatic access is enabled for the user.
4. Attach policies that grant the user sufficient permissions to create, modify, and delete resources as required by the Terraform configurations.
5. On the final screen, you will be provided with an Access Key ID and Secret Access Key for the user. Store these credentials securely.
6. Configure the AWS CLI with the credentials by running `aws configure` and entering the Access Key ID and Secret Access Key when prompted.

### Deployment with Terraform
    ```bash
    git clone https://github.com/mzandinia/sample-project-on-AWS
    cd sample-project-on-AWS/week3
    terraform init
    terraform plan
    terraform apply
    ```
   At this stage, all necessary resources will be created.

### Login to Nexus Repository

   at this moment login to Nexus via the link and password that provided to you

   ![alt text](./images/aws%2001.png)

   click in the sign in button on the top right on the screen

   ![alt text](./images/aws%2002.png)

   enter the `admin` user and the password provided to you in the last step

   ![alt text](./images/aws%2003.png)

   click `next` to continue

   ![alt text](./images/aws%2004.png)

   enter a new strong password

   ![alt text](./images/aws%2005.png)

   choose `enable anonymous access` and then click `next` to continue

   ![alt text](./images/aws%2006.png)

   choose `finish`

   ![alt text](./images/aws%2007.png)

### Configure Nexus by Ansible

   Login to Nexus via ssh (use `ubuntu` as username and `changeme` as password)

   ![alt text](./images/aws%2009.png)

   Login to Ansible via ssh (use `ubuntu` as username and `changeme` as password)

   ![alt text](./images/aws%2010.png)

   Clone the repository
   `git clone https://github.com/mzandinia/sample-project-on-AWS.git`

   ![alt text](./images/aws%2011.png)

   `cd sample-project-on-AWS/week3/ansible-project`

   ![alt text](./images/aws%2012.png)

   In this step we want to configure nexus repository. We create the following repositories.
   -    Ubuntu-proxy
   -    Debian-proxy
   -    Almalinux-proxy
   -    Rockylinux-porxy
   -    Splunk-proxy

   There are various variables in the `config-nexus.yml` that if you want to change some remote url then you can do it through that. After review the configuration run

   `ansible-playbook nexus-configuration/config-nexus.yml`

   ![alt text](./images/aws%2013.png)

   Ansible prompt you to enter the password of admin user of nexus. Enter the password to continue

   ![alt text](./images/aws%2014.png)

   you can see the results on the following images:

   ![alt text](./images/aws%2015.png)

   ![alt text](./images/aws%2016.png)

### Configure Linux Instances to use the nexus repo

   Run the following command to configure all Linux instances.

   `ansible-playbook repo-configuration/repos-config.yml`

   ![alt text](./images/aws%2017.png)

   ![alt text](./images/aws%2018.png)


### Install Splunk

   Run the following command to install Splunk

   `ansible-playbook splunk-configuration/splunk-config.yml`

   ![alt text](./images/aws%2019.png)

   ![alt text](./images/aws%2020.png)

   After playbook was finished correctly you can login to splunk instance and see that Splunk is running correctly.

   ![alt text](./images/aws%2021.png)

   ![alt text](./images/aws%2022.png)


## Contributions

Contributions to this project are welcome. Please fork the repository, make your changes, and submit a pull request.

## License

This project is open source and available under the [MIT License](LICENSE).
