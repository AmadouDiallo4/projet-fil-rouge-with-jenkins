data "aws_ami" "app_ami" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "projet_fil_rouge" {
  ami             = data.aws_ami.app_ami.id
  instance_type   = var.instancetype
  key_name        = var.aws_key_name
  tags            = var.aws_common_tag
  security_groups = ["${var.aws_sg_name}"]

  provisioner "remote-exec" {
    inline = [ 
      "sudo apt install -y curl git zip",
      "curl -fsSL https://get.docker.com -o get-docker.sh",
      "sudo chmod +x get-docker.sh",
      "sudo sh get-docker.sh",
      "sudo usermod -aG docker $USER",
      "sudo systemctl enable docker",
      "sudo systemctl start docker",
      "sudo curl -L https://github.com/docker/compose/releases/download/v2.23.3/docker-compose-$(uname -s)-$(uname -m) -o /usr/bin/docker-compose",
      "sudo chmod +x /usr/bin/docker-compose",
      "sudo docker version",
      "sudo docker-compose version",
      "sudo rm -rf get-docker.sh"
    ]

    connection {
    type     = "ssh"
    user     = "${var.username}"
    private_key = file("./files/${var.aws_key_name}.pem")
    host     = "${self.public_ip}"
  }
  }

  root_block_device {
    delete_on_termination = true
  }
}

resource "aws_eip" "lb" {
  instance = aws_instance.projet_fil_rouge.id
  domain   = "vpc"
  tags = var.aws_eip_tag
  
  provisioner "local-exec" {
    command =  "echo ${aws_eip.lb.public_ip} > files/infos_ec2.txt"
    #command = <<EOT
    #  echo ${aws_eip.lb.public_ip} >> files/infos_ec2.txt
    #  echo "ansible_host: $(awk '{print $1}' files/infos_ec2.txt)" > ../../ansible/host_vars/jenkins.yml
    #EOT
  }
}

resource "aws_security_group" "allow_http_https_ssh" {
  name        = var.aws_sg_name
  description = "Allow HTTP inbound traffic"

  ingress {
    description      = "Webapp Access"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "Pgadmin Access"
    from_port        = 8200
    to_port          = 8200
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "Odoo Access"
    from_port        = 8069
    to_port          = 8069
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = var.aws_sg_tag
}

