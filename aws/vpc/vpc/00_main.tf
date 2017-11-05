variable "tag" { type = "map" }
variable "cidr_block" {}
variable "default_sg" {}

resource "aws_vpc" "vpc01" {
   cidr_block                       = "${var.cidr_block}"
   assign_generated_ipv6_cidr_block = "true"
   tags                             = "${var.tag}"
   default_security_group_id        = "${var.default_sg}"
}

output "vpc01_id" {
   value = "${aws_vpc.vpc01.id}"
}
