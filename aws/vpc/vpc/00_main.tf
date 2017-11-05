variable "tag" { type = "map" }
variable "cidr_block" {}

resource "aws_vpc" "vpc01" {
   cidr_block                       = "${var.cidr_block}"
   assign_generated_ipv6_cidr_block = "true"
   tags                             = "${var.tag}"
}

output "vpc01_id" {
   value = "${vpc01.id}"
}