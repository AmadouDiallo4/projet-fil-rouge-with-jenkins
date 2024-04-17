
variable "aws_access_key" {
  type    = string
  default = ""
}

variable "aws_secret_key" {
  type    = string
  default = ""
}

variable "aws_prod_instancetype" {
  type        = string
  description = "definir le type de l'instance"
  default     = "t2.medium"
}

variable "aws_prod_common_tag" {
  type        = map(any)
  description = "definir le tag de l'image"
  default = {
    Name = "jenkins-prod-tag"
  }
}

variable "region" {
  type        = string
  description = "set aws region"
  default     = "us-east-1"
}

variable "aws_prod_key_name" {
  type    = string
  default = "devops-gbane"
}

variable "aws_prod_sg_name" {
  type        = string
  description = "set sg name"
  default     = "jenkins-prod-sg"

}

variable "aws_prod_tfstate" {
  type        = string
  description = "Prod tfstate"
  default     = "jenkins-prod.tfstate"
}


variable "aws_prod_sg_tag" {
  type        = map
  description = "set security group tag"
  default = {
    Name = "jenkins-prod-sg"
  }
}

variable "aws_prod_eip_tag" {
  type        = map
  description = "set security group tag"
  default = {
    Name = "jenkins-prod-eip"
  }
}

variable "ebs_common_tag" {
  type        = map(any)
  description = "definir le tag de l'ebs"
  default = {
    Name = "jenkins-prod-ebs"
  }
}

variable "deploy_environment" {
  type = string
  description = "describe where apps are deployed"
  default = "prod"
}

variable "aws_prod_username" {
  type = string
  description = "EC2 username"
  default = "ubuntu"
}