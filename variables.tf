variable "enabled" {
  type        = bool
  description = "Whether to create the EC2 instance"
  default     = true
}

variable "ssh_key_pair" {
  type        = string
  description = "SSH key pair to be provisioned on the instance"
  default     = null
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Associate a public IP address with the instance"
  default     = false
}

variable "user_data" {
  type        = string
  description = "The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; use `user_data_base64` instead"
  default     = null
}

variable "user_data_base64" {
  type        = string
  description = "Can be used instead of `user_data` to pass base64-encoded binary data directly. Use this instead of `user_data` whenever the value is not a valid UTF-8 string. For example, gzip-encoded user data must be base64-encoded and passed via this argument to avoid corruption"
  default     = null
}

variable "instance_type" {
  type        = string
  description = "The type of the instance"
  default     = "t2.micro"
}

variable "burstable_mode" {
  type        = string
  description = "Enable burstable mode for the instance. Can be standard or unlimited. Applicable only for T2/T3/T4g instance types."
  default     = null
}

variable "security_groups" {
  description = "A list of Security Group IDs to associate with EC2 instance."
  type        = list(string)
  default     = []
}

variable "availability_zone" {
  type        = string
  description = "Availability Zone the instance is launched in. If not set, will be launched in the first AZ of the region"
  default     = ""
}

variable "ami" {
  type        = string
  description = "The AMI to use for the instance. By default it is the AMI provided by Amazon with Ubuntu 16.04"
  default     = ""
}

variable "ebs_optimized" {
  type        = bool
  description = "Launched EC2 instance will be EBS-optimized"
  default     = true
}

variable "disable_api_termination" {
  type        = bool
  description = "Enable EC2 Instance Termination Protection"
  default     = false
}

variable "monitoring" {
  type        = bool
  description = "Launched EC2 instance will have detailed monitoring enabled"
  default     = true
}

variable "private_ip" {
  type        = string
  description = "Private IP address to associate with the instance in the VPC"
  default     = null
}

variable "secondary_private_ips" {
  type        = list(string)
  description = "List of secondary private IP addresses to associate with the instance in the VPC"
  default     = []
}

variable "source_dest_check" {
  type        = bool
  description = "Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs"
  default     = true
}

variable "ipv6_address_count" {
  type        = number
  description = "Number of IPv6 addresses to associate with the primary network interface. Amazon EC2 chooses the IPv6 addresses from the range of your subnet (-1 to use subnet default)"
  default     = 0
}

variable "instance_profile" {
  type        = string
  description = "A pre-defined profile to attach to the instance (default is to build our own)"
  default     = ""
}

variable "instance_initiated_shutdown_behavior" {
  type        = string
  description = "Specifies whether an instance stops or terminates when you initiate shutdown from the instance. Can be one of 'stop' or 'terminate'."
  default     = null
}

variable "tenancy" {
  type        = string
  default     = "default"
  description = "Tenancy of the instance (if the instance is running in a VPC). An instance with a tenancy of 'dedicated' runs on single-tenant hardware. The 'host' tenancy is not supported for the import-instance command. Valid values are 'default', 'dedicated', and 'host'."
  validation {
    condition     = contains(["default", "dedicated", "host"], lower(var.tenancy))
    error_message = "Tenancy field can only be one of default, dedicated, host."
  }
}

variable "external_network_interface_enabled" {
  type        = bool
  default     = false
  description = "Wheter to attach an external ENI as the eth0 interface for the instance. Any change to the interface will force instance recreation."
}

variable "external_network_interfaces" {
  type = list(object({
    delete_on_termination = bool
    device_index          = number
    network_card_index    = number
    network_interface_id  = string
  }))
  description = "The external interface definitions to attach to the instances. This depends on the instance type"
  default     = null
}

variable "device_name_list" {
  description = "Details of the EBS devices to mount"

  type = map(object({
    size          = optional(number)
    iops          = optional(number)
    throughput    = optional(number)
    type          = optional(string)
    tags          = optional(map(string))
    encrypted     = optional(bool)
    kms_key_id    = optional(string)
    kms_key_alias = optional(string)
  }))

  default = {}
}

variable "metadata_options" {
  type = object({
    http_endpoint               = string
    http_protocol_ipv6          = optional(string)
    instance_metadata_tags      = optional(string)
    http_put_response_hop_limit = optional(number)
    http_tokens                 = optional(string)
  })
  description = "Metadata options for the instance"
  default     = null
}

variable "public_ip_addresses" {
  type        = map(any)
  description = "List of public IP addresses to associate with the instance in the VPC"
  default     = {}
}

variable "launch_template" {
  type        = list(any)
  description = "Launch template to use for the instance"
  default     = []
}

variable "subnet_name" {
  type        = string
  description = "VPC Subnet name the instance is launched in"
  default     = ""
}

variable "subnet_id" {
  type        = string
  description = "VPC Subnet ID the instance is launched in"
  default     = ""
}

variable "vpc_name" {
  type        = string
  description = "The name of the VPC"
  default     = null
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "root_block_device" {
  type = object({
    volume_type           = string
    volume_size           = number
    throughput            = number
    delete_on_termination = bool
    encrypted             = bool
    kms_key_id            = optional(string)
    kms_key_alias         = optional(string)
    tags                  = optional(map(string))
  })
  description = "Root block device configuration"
}
