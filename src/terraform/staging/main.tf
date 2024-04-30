provider "aws" {
  region     = var.region
}

# loading ec2module
module "ec2" {
  source         = "../modules/ec2module"
  instancetype   = var.aws_staging_instancetype
  aws_common_tag = var.aws_staging_common_tag
  aws_sg_name    = var.aws_staging_sg_name
  aws_sg_tag     = var.aws_staging_sg_tag
  aws_eip_tag    = var.aws_staging_eip_tag
  deploy_environment = var.deploy_environment
}

# Generate inventory file
resource "local_file" "staging_inventory" {
  filename = "staging.yml"
  content = <<EOF
---
ansible_host: ${module.ec2.ec2_eip}
ansible_user: ${var.aws_staging_username}
ansible_ssh_private_key_file: ../../terraform/files/${var.aws_key_name}.pem
EOF
}


# Generate ic-webapp- deployment file
resource "local_file" "deployment_template" {
  content = templatefile("deployment_template.yml", {
    INSTANCE = "${module.ec2.ec2_eip}"
    }
  )
  filename = "ic-webapp-deployment.yml"
}