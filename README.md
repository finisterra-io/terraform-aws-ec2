
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.67 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.67 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ebs_volume.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_volume) | resource |
| [aws_eip.additional](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_eip.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_instance.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_network_interface.additional](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface) | resource |
| [aws_network_interface_attachment.additional](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface_attachment) | resource |
| [aws_volume_attachment.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/volume_attachment) | resource |
| [aws_ami.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_kms_key.ebs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |
| [aws_kms_key.root_ebs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |
| [aws_subnet.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_ips_count"></a> [additional\_ips\_count](#input\_additional\_ips\_count) | Count of additional EIPs | `number` | `0` | no |
| <a name="input_ami"></a> [ami](#input\_ami) | The AMI to use for the instance. By default it is the AMI provided by Amazon with Ubuntu 16.04 | `string` | `""` | no |
| <a name="input_associate_public_ip_address"></a> [associate\_public\_ip\_address](#input\_associate\_public\_ip\_address) | Associate a public IP address with the instance | `bool` | `false` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | Availability Zone the instance is launched in. If not set, will be launched in the first AZ of the region | `string` | `""` | no |
| <a name="input_burstable_mode"></a> [burstable\_mode](#input\_burstable\_mode) | Enable burstable mode for the instance. Can be standard or unlimited. Applicable only for T2/T3/T4g instance types. | `string` | `null` | no |
| <a name="input_device_name_list"></a> [device\_name\_list](#input\_device\_name\_list) | Details of the EBS devices to mount | <pre>map(object({<br>    size          = optional(number)<br>    iops          = optional(number)<br>    throughput    = optional(number)<br>    type          = optional(string)<br>    tags          = optional(map(string))<br>    encrypted     = optional(bool)<br>    kms_key_id    = optional(string)<br>    kms_key_alias = optional(string)<br>  }))</pre> | `{}` | no |
| <a name="input_disable_api_termination"></a> [disable\_api\_termination](#input\_disable\_api\_termination) | Enable EC2 Instance Termination Protection | `bool` | `false` | no |
| <a name="input_ebs_optimized"></a> [ebs\_optimized](#input\_ebs\_optimized) | Launched EC2 instance will be EBS-optimized | `bool` | `true` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Whether to create the EC2 instance | `bool` | `true` | no |
| <a name="input_external_network_interface_enabled"></a> [external\_network\_interface\_enabled](#input\_external\_network\_interface\_enabled) | Wheter to attach an external ENI as the eth0 interface for the instance. Any change to the interface will force instance recreation. | `bool` | `false` | no |
| <a name="input_external_network_interfaces"></a> [external\_network\_interfaces](#input\_external\_network\_interfaces) | The external interface definitions to attach to the instances. This depends on the instance type | <pre>list(object({<br>    delete_on_termination = bool<br>    device_index          = number<br>    network_card_index    = number<br>    network_interface_id  = string<br>  }))</pre> | `null` | no |
| <a name="input_instance_initiated_shutdown_behavior"></a> [instance\_initiated\_shutdown\_behavior](#input\_instance\_initiated\_shutdown\_behavior) | Specifies whether an instance stops or terminates when you initiate shutdown from the instance. Can be one of 'stop' or 'terminate'. | `string` | `null` | no |
| <a name="input_instance_profile"></a> [instance\_profile](#input\_instance\_profile) | A pre-defined profile to attach to the instance (default is to build our own) | `string` | `""` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The type of the instance | `string` | `"t2.micro"` | no |
| <a name="input_ipv6_address_count"></a> [ipv6\_address\_count](#input\_ipv6\_address\_count) | Number of IPv6 addresses to associate with the primary network interface. Amazon EC2 chooses the IPv6 addresses from the range of your subnet (-1 to use subnet default) | `number` | `0` | no |
| <a name="input_launch_template"></a> [launch\_template](#input\_launch\_template) | Launch template to use for the instance | `list(any)` | `[]` | no |
| <a name="input_metadata_http_endpoint"></a> [metadata\_http\_endpoint](#input\_metadata\_http\_endpoint) | Whether the metadata service is available | `string` | `"enabled"` | no |
| <a name="input_metadata_http_protocol_ipv6"></a> [metadata\_http\_protocol\_ipv6](#input\_metadata\_http\_protocol\_ipv6) | Whether IPv6 is enabled for the metadata service. | `string` | `null` | no |
| <a name="input_metadata_http_put_response_hop_limit"></a> [metadata\_http\_put\_response\_hop\_limit](#input\_metadata\_http\_put\_response\_hop\_limit) | The desired HTTP PUT response hop limit (between 1 and 64) for instance metadata requests. | `number` | `2` | no |
| <a name="input_metadata_http_tokens"></a> [metadata\_http\_tokens](#input\_metadata\_http\_tokens) | Whether or not the metadata service requires session tokens, also referred to as Instance Metadata Service Version 2. | `string` | `"required"` | no |
| <a name="input_metadata_instance_metadata_tags"></a> [metadata\_instance\_metadata\_tags](#input\_metadata\_instance\_metadata\_tags) | Whether the tags are enabled in the metadata service. | `string` | `null` | no |
| <a name="input_monitoring"></a> [monitoring](#input\_monitoring) | Launched EC2 instance will have detailed monitoring enabled | `bool` | `true` | no |
| <a name="input_private_ip"></a> [private\_ip](#input\_private\_ip) | Private IP address to associate with the instance in the VPC | `string` | `null` | no |
| <a name="input_public_ip_addresses"></a> [public\_ip\_addresses](#input\_public\_ip\_addresses) | List of public IP addresses to associate with the instance in the VPC | `map(any)` | `{}` | no |
| <a name="input_root_block_device"></a> [root\_block\_device](#input\_root\_block\_device) | Root block device configuration | <pre>object({<br>    volume_type           = string<br>    volume_size           = number<br>    iops                  = number<br>    throughput            = number<br>    delete_on_termination = bool<br>    encrypted             = bool<br>    kms_key_id            = optional(string)<br>    kms_key_alias         = optional(string)<br>    tags                  = optional(map(string))<br>  })</pre> | n/a | yes |
| <a name="input_secondary_private_ips"></a> [secondary\_private\_ips](#input\_secondary\_private\_ips) | List of secondary private IP addresses to associate with the instance in the VPC | `list(string)` | `[]` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | A list of Security Group IDs to associate with EC2 instance. | `list(string)` | `[]` | no |
| <a name="input_source_dest_check"></a> [source\_dest\_check](#input\_source\_dest\_check) | Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs | `bool` | `true` | no |
| <a name="input_ssh_key_pair"></a> [ssh\_key\_pair](#input\_ssh\_key\_pair) | SSH key pair to be provisioned on the instance | `string` | `null` | no |
| <a name="input_subnet"></a> [subnet](#input\_subnet) | VPC Subnet ID the instance is launched in | `string` | `""` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | VPC Subnet ID the instance is launched in | `string` | `""` | no |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | VPC Subnet name the instance is launched in | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_tenancy"></a> [tenancy](#input\_tenancy) | Tenancy of the instance (if the instance is running in a VPC). An instance with a tenancy of 'dedicated' runs on single-tenant hardware. The 'host' tenancy is not supported for the import-instance command. Valid values are 'default', 'dedicated', and 'host'. | `string` | `"default"` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; use `user_data_base64` instead | `string` | `null` | no |
| <a name="input_user_data_base64"></a> [user\_data\_base64](#input\_user\_data\_base64) | Can be used instead of `user_data` to pass base64-encoded binary data directly. Use this instead of `user_data` whenever the value is not a valid UTF-8 string. For example, gzip-encoded user data must be base64-encoded and passed via this argument to avoid corruption | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_additional_eni_ids"></a> [additional\_eni\_ids](#output\_additional\_eni\_ids) | Map of ENI to EIP |
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the instance |
| <a name="output_id"></a> [id](#output\_id) | Disambiguated ID of the instance |
| <a name="output_name"></a> [name](#output\_name) | Instance name |
| <a name="output_primary_network_interface_id"></a> [primary\_network\_interface\_id](#output\_primary\_network\_interface\_id) | ID of the instance's primary network interface |
| <a name="output_private_dns"></a> [private\_dns](#output\_private\_dns) | Private DNS of instance |
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | Private IP of instance |
| <a name="output_security_group_ids"></a> [security\_group\_ids](#output\_security\_group\_ids) | IDs on the AWS Security Groups associated with the instance |
| <a name="output_ssh_key_pair"></a> [ssh\_key\_pair](#output\_ssh\_key\_pair) | Name of the SSH key pair provisioned on the instance |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
