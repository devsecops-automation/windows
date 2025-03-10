# Windows EC2 Terraform Project

This project automates the deployment of a Windows Server 2022 EC2 instance on AWS with IIS web server pre-installed.

## Project Structure

```plaintext
.
├── cleanup.sh       # Cleanup script for destroying resources
├── data.tf         # Data sources for AMI and IP lookup
├── locals.tf       # Local variable definitions
├── main.tf         # Main Terraform configuration
├── outputs.tf      # Output definitions
├── provider.tf     # AWS provider configuration
├── README.md       # This documentation
├── terraform.tfvars # Variable values
└── variables.tf    # Variable declarations
```

## Features

- 🖥️ Windows Server 2022 EC2 instance
- 🌐 IIS Web Server auto-installation
- 🔐 Auto-generated SSH key pairs
- 🛡️ Security group with RDP access
- 🏷️ Dynamic resource naming
- 📝 Basic "Hello, World!" web page

## Prerequisites

- Terraform >= 1.5.0
- AWS Provider >= 5.0
- AWS CLI with configured credentials
- Linux/Unix environment for scripts

## Quick Start

1. Clone this repository
2. Configure `terraform.tfvars`:

```hcl
instance_type = "t3.large"
region        = "us-east-1"
name          = "devops"
```

3. Initialize and apply:

```bash
terraform init
terraform apply
```

## Login into Windows VM
1. You need the IP from terraform output
2. Username:  `Administrator`
3. Password for VM, run:

```sh
./get-password.sh
```

## Security Features

- RDP access (port 3389) limited to your IP
- Automated key pair generation
- Password encryption using key pairs
- t2.micro instances blocked for stability

## Resource Cleanup

Quick cleanup using the provided script:

```bash
./cleanup.sh
```

Or manual cleanup:

```bash
terraform destroy -auto-approve
```

## Modules Used

- **windows**: EC2 instance creation
- **aws_key**: SSH key pair generation
- **security_group**: RDP access rules
- **unique_name**: Resource naming

## Generated Files

The deployment creates:
- `.pem` key file for instance access
- `.json` file with instance password data

## Important Notes

1. Key files (`.pem`) are gitignored for security
2. Instance type must be t2.small or larger
3. Security group allows RDP only from deploying IP
4. Web server displays "Hello, World!" on root path

## Variables

| Name | Description | Type | Default |
|------|-------------|------|---------|
| instance_type | EC2 instance size | string | t3.large |
| region | AWS deployment region | string | us-east-1 |
| name | Resource name prefix | string | devops |

## Outputs

| Name | Description |
|------|-------------|
| windows_ip_address | Public IP of Windows instance |
| instance_id | EC2 instance ID |

## Security Groups

- **Inbound**: RDP (3389) from deployer IP
- **Outbound**: All traffic to deployer IP

## Windows Features

- Windows Server 2022 English Full Base
- IIS Web Server
- Custom index.html