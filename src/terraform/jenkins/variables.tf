variable "aws_access_key" {
  type    = string
  default = ""
}

variable "aws_secret_key" {
  type    = string
  default = ""
}

variable "aws_staging_instancetype" {
  type        = string
  description = "definir le type de l'instance"
  default     = "t2.medium"
}

variable "aws_staging_common_tag" {
  type        = map(any)
  description = "definir le tag de l'image"
  default = {
    Name = "jenkins-test"
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

variable "aws_staging_sg_name" {
  type        = string
  description = "set sg name"
  default     = "jenkins-sg"

}

variable "aws_staging_eip_tag" {
  type = map(any)
  description = "EIP tag"
  default = {
    Name  = "jenkins-eip"
  }
}

variable "ebs_common_tag" {
  type        = map(any)
  description = "definir le tag de l'ebs"
  default = {
    Name = "jenkins-ebs"
  }
}

variable "aws_staging_sg_tag" {
  type        = map
  description = "set security group tag"
  default = {
    Name = "jenkins-sg-tag"
  }
}
variable "aws_public_ip" {
  type = string
  description = "set public ip"
  default = "eip"
}

variable "deploy_environment" {
  type = string
  description = "describe where apps are deployed"
  default = "/home/ubuntu"
}

variable "aws_username" {
  type = string
  description = "EC2 username"
  default = "ubuntu"
}