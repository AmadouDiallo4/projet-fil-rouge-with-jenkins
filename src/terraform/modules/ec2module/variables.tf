variable "aws_access_key" {
  type    = string
  default = ""
}

variable "aws_secret_key" {
  type    = string
  default = ""
}

variable "instancetype" {
  type        = string
  description = "definir le type de l'instance"
  default     = "t2.nano"
}

variable "aws_common_tag" {
  type        = map(any)
  description = "definir le tag de l'image"
  default = {
    Name = "ec2-default"
  }
}

variable "region" {
  type        = string
  description = "set aws region"
  default     = "us-east-1"
}

variable "aws_key_name" {
  type    = string
  default = "devops-gbane"
}

variable "aws_sg_name" {
  type        = string
  description = "set sg name"
  default     = "default-sg"

}

variable "aws_tfstate" {
  type        = string
  description = "Default tfstate"
  default     = "default-gbane.tfstate"
}

variable "aws_s3" {
  type        = string
  description = "STG S3"
  default     = "gbane-state-bucket"
}

variable "aws_sg_tag" {
  type        = map
  description = "set security group tag"
  default = {
    Name = "sg-tag"
  }
}

variable "aws_eip_tag" {
  type        = map
  description = "set Ec2 IP tag"
  default = {
    Name = "eip-tag"
  }
}

variable "username" {
  type = string
  description = "system username"
  default = "ubuntu"
}

variable "deploy_environment" {
  type = string
  description = "describe where apps are deployed"
  default = "dev"
}

variable "aws_public_ip" {
  type = string
  description = "set public ip"
  default = "eip"
}