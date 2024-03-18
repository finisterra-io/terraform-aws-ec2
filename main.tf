locals {
  enabled        = var.enabled
  instance_count = local.enabled ? 1 : 0
  ami            = var.ami != "" ? var.ami : one(data.aws_ami.default[*].image_id)
}

#already defined in dynamic "root_block_device", and dynamic "metadata_options" 
#tfsec:ignore:aws-ec2-enable-at-rest-encryption tfsec:ignore:aws-ec2-enforce-http-token-imds
resource "aws_instance" "default" {
  count                                = local.instance_count
  ami                                  = local.ami
  availability_zone                    = var.availability_zone
  instance_type                        = var.instance_type
  ebs_optimized                        = var.ebs_optimized
  disable_api_termination              = var.disable_api_termination
  user_data                            = var.user_data
  user_data_base64                     = var.user_data_base64
  iam_instance_profile                 = var.instance_profile
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior
  associate_public_ip_address          = var.external_network_interface_enabled ? null : var.associate_public_ip_address
  key_name                             = var.ssh_key_pair
  subnet_id                            = var.subnet_name != "" ? data.aws_subnet.default[0].id : var.subnet_id
  monitoring                           = var.monitoring
  private_ip                           = var.private_ip
  secondary_private_ips                = var.external_network_interface_enabled ? null : var.secondary_private_ips
  source_dest_check                    = var.external_network_interface_enabled ? null : var.source_dest_check
  ipv6_address_count                   = var.external_network_interface_enabled && var.ipv6_address_count == 0 ? null : var.ipv6_address_count
  tenancy                              = var.tenancy

  vpc_security_group_ids = var.external_network_interface_enabled ? null : compact(
    concat(
      var.security_groups
    )
  )

  dynamic "network_interface" {
    for_each = var.external_network_interface_enabled ? var.external_network_interfaces : []
    content {
      delete_on_termination = network_interface.value.delete_on_termination
      device_index          = network_interface.value.device_index
      network_card_index    = network_interface.value.network_card_index
      network_interface_id  = network_interface.value.network_interface_id
    }

  }

  dynamic "launch_template" {
    for_each = var.launch_template
    content {
      id      = launch_template.value.id
      version = launch_template.value.version
    }
  }

  dynamic "root_block_device" {
    for_each = var.root_block_device != null ? [var.root_block_device] : []
    content {
      volume_type           = root_block_device.value.volume_type
      volume_size           = root_block_device.value.volume_size
      iops                  = root_block_device.value.iops
      throughput            = root_block_device.value.throughput
      delete_on_termination = root_block_device.value.delete_on_termination
      encrypted             = root_block_device.value.encrypted
      kms_key_id            = lookup(root_block_device.value, "kms_key_alias", null) != null ? data.aws_kms_key.root_ebs[0].arn : root_block_device.value.kms_key_id
      tags                  = root_block_device.value.tags
    }
  }

  dynamic "metadata_options" {
    for_each = var.metadata_options != null ? [var.metadata_options] : []
    content {
      http_endpoint               = metadata_options.value.http_endpoint
      http_protocol_ipv6          = try(metadata_options.value.http_protocol_ipv6, null)
      instance_metadata_tags      = try(metadata_options.value.instance_metadata_tags, null)
      http_put_response_hop_limit = try(metadata_options.value.http_put_response_hop_limit, null)
      http_tokens                 = try(metadata_options.value.http_tokens, null)
    }
  }

  credit_specification {
    cpu_credits = var.burstable_mode
  }

  tags = var.tags


  lifecycle {
    ignore_changes = [user_data, user_data_replace_on_change, credit_specification, metadata_options[0].http_protocol_ipv6]
  }
}

resource "aws_eip" "default" {
  for_each = var.enabled ? var.public_ip_addresses : {}
  instance = one(aws_instance.default[*].id)
  domain   = "vpc"
  tags     = each.value.tags
}

resource "aws_ebs_volume" "default" {
  for_each          = var.device_name_list
  availability_zone = var.availability_zone
  size              = each.value.size
  iops              = each.value.iops
  throughput        = each.value.throughput
  type              = each.value.type
  tags              = each.value.tags
  encrypted         = each.value.encrypted
  kms_key_id        = each.value.kms_key_alias != null ? data.aws_kms_key.ebs[each.key].arn : each.value.kms_key_id
}

resource "aws_volume_attachment" "default" {
  for_each    = var.device_name_list
  device_name = each.key
  volume_id   = aws_ebs_volume.default[each.key].id
  instance_id = one(aws_instance.default[*].id)
}
