module "windows" {
  source                 = "git::https://github.com/devops-terraform-aws/ec2-instance-module.git"
  ami                    = data.aws_ami.windows-2025.id
  key_name               = module.aws_key.get_key_name
  instance_type          = var.instance_type
  vpc_security_group_ids = module.security_group.security_id
  region                 = var.region
  subnet_id              = module.vpc.subnet_id
  get_password_data      = false
  tags = {
    "Name" = "windows-${local.name}-${module.unique_name.unique}"
  }
  user_data = <<-EOF
    <powershell>
    # Install IIS Web Server
    Install-WindowsFeature -Name Web-Server

    # Create index.html file
    $webpath = "C:\inetpub\wwwroot\index.html"
    "Hello, World!" | Set-Content -Path $webpath -Force

    Remove-Item -Path "C:\inetpub\wwwroot\iis*" -Force -Recurse
    </powershell>
    EOF

  depends_on = [module.vpc]
}

resource "terraform_data" "generated_key" {
  provisioner "local-exec" {
    command = <<-EOT
        echo '${module.aws_key.private_key}' > ./'${module.unique_name.unique}'.pem
        chmod 400 ./'${module.unique_name.unique}'.pem
      EOT
  }
}

module "aws_key" {
  source   = "git::https://github.com/devops-terraform-aws/ssh-key-module.git?ref=v1.0.0"
  key_name = module.unique_name.unique
}

module "unique_name" {
  source = "git::https://github.com/devops-terraform-aws/random-module.git?ref=v1.0.0"
}

module "security_group" {
  source = "git::https://github.com/devops-terraform-aws/security-group-module.git"
  name   = "${local.name}-${module.unique_name.unique}"
  vpc_id = module.vpc.vpc_id
  tags = {
    "Name" = "sg-${local.name}-${module.unique_name.unique}"
  }
  ingress_rules = [
    {
      description = "Allow RDP traffic"
      from_port   = 3389
      to_port     = 3389
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "Allow HTTP traffic"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]
  egress_rules = [
    {
      description = "Allow all traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]
}

module "vpc" {
  source = "../vpc"

  vpc_cidr_block = "1.0.0.0/16"
  public_subnets = "1.0.0.0/24"
  tags = {
    "Name" = "vpc-${local.name}-${module.unique_name.unique}"
  }
  public_routes = [
    {
      cidr_block = "0.0.0.0/0"
    }
  ]
}