output "private_ip" {
  description = "Private IP of instance"
  value       = one(aws_instance.default[*].private_ip)
}

output "private_dns" {
  description = "Private DNS of instance"
  value       = one(aws_instance.default[*].private_dns)
}

output "id" {
  description = "Disambiguated ID of the instance"
  value       = one(aws_instance.default[*].id)
}

output "arn" {
  description = "ARN of the instance"
  value       = one(aws_instance.default[*].arn)
}

output "ssh_key_pair" {
  description = "Name of the SSH key pair provisioned on the instance"
  value       = var.ssh_key_pair
}

output "security_group_ids" {
  description = "IDs on the AWS Security Groups associated with the instance"
  value = compact(
    concat(
      var.security_groups
    )
  )
}

output "primary_network_interface_id" {
  description = "ID of the instance's primary network interface"
  value       = one(aws_instance.default[*].primary_network_interface_id)
}
