output "bastion_host_private_ip" {
  value = aws_instance.bastion_host.private_ip
}

output "bastion_host_public_ip" {
  value = aws_instance.bastion_host.public_ip
}

output "private_instance_private_ip" {
  value = aws_instance.private_instance.private_ip
}

output "private_instance_public_ip" {
  value = aws_instance.private_instance.public_ip
}
