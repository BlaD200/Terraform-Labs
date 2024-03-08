output "private_key_pem" {
  value     = module.key-pair.private_key_pem
  sensitive = true
}

output "public_key_pem" {
  value     = module.key-pair.public_key_pem
  sensitive = true
}

output "ec2_instance_public_ip" {
  value = module.ec2_instance.public_ip
}
