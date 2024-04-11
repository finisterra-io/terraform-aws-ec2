output "id" {
  value       = aws_key_pair.this[0].key_name
  description = "The key name to use for the instance"
}
