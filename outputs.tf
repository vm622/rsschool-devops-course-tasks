output "network_bastion_host_private_ip" {
  value = module.network.bastion_host_private_ip
}

output "network_bastion_host_public_ip" {
  value = module.network.bastion_host_public_ip
}

output "network_private_instance_private_ip" {
  value = module.network.private_instance_private_ip
}

output "network_private_instance_public_ip" {
  value = module.network.private_instance_public_ip
}
