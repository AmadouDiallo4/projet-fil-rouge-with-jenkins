output "ec2_eip_id" {
  description = "Mise à disposition du id de l'EIP"
  value = aws_eip.lb.id #aws_eip.ec2_lb.id
}

output "ec2_eip" {
  description = "Mise à disposition de l'adresse IP publique"
  value = aws_eip.lb.public_ip
}