output "windows_ip_address" {
  value       = module.windows.public_ip_address
  description = "The public IP address of the Windows instance"
}

output "instance_id" {
  value       = module.windows.instance_id
  description = "The ID of the Windows instance"
}

output "region" {
  value       = module.windows.region
  description = "The region in which the Windows instance was created"
}

output "username" {
  value       = "Administrator"
  description = "The username of the EC2 instance"
}

output "unique_name" {
  value       = module.unique_name.unique
  description = "The unique name of the EC2 instance"
}