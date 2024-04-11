resource "aws_key_pair" "this" {
  count      = var.enabled ? 1 : 0
  key_name   = var.key_name
  public_key = var.public_key

  lifecycle {
    ignore_changes = [public_key]
  }
}
