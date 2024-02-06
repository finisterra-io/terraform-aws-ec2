locals {
  additional_ips_count = var.enabled && var.associate_public_ip_address && var.additional_ips_count > 0 ? var.additional_ips_count : 0
}

resource "aws_network_interface" "additional" {
  count     = local.additional_ips_count
  subnet_id = var.subnet

  security_groups = compact(
    concat(
      var.security_groups
    )
  )

  tags = var.tags
}

resource "aws_network_interface_attachment" "additional" {
  count                = local.additional_ips_count
  instance_id          = one(aws_instance.default[*].id)
  network_interface_id = aws_network_interface.additional[count.index].id
  device_index         = 1 + count.index
}

resource "aws_eip" "additional" {
  count             = local.additional_ips_count
  domain            = "vpc"
  network_interface = aws_network_interface.additional[count.index].id
}
