data "aws_subnet" "default" {
  count = var.subnet_name != "" ? 1 : 0
  filter {
    name   = "tag:Name"
    values = [var.subnet_name]
  }
}

data "aws_ami" "default" {
  count       = var.ami == "" ? 1 : 0
  most_recent = "true"

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

data "aws_kms_key" "ebs" {
  for_each = { for key, value in var.device_name_list : key => value if value.kms_key_alias != null }
  key_id   = each.value.kms_key_alias
}

data "aws_kms_key" "root_ebs" {
  count  = lookup(var.root_block_device, "kms_key_alias", null) != null ? 1 : 0
  key_id = var.root_block_device.kms_key_alias
}
