variable "enabled" {
  type        = bool
  description = "Enable EC2 instance"
  default     = true
}

variable "key_name" {
  type        = string
  description = "The key name to use for the instance"
}

variable "public_key" {
  type        = string
  description = "The public key to use for the instance"
}