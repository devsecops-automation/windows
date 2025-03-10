output "windows_ip_address" {
  value       = module.windows.ip_address
  description = "The public IP address of the Windows instance"
}

output "instance_id" {
  value       = module.windows.instance_id
  description = "The ID of the Windows instance"
}