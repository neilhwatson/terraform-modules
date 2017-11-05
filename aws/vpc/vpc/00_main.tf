variable "tag" { type = "map" }
variable "cidr_block" {}

resource "aws_vpc" "vpc01" {
   cidr_block                       = "${var.cidr_block}"
   assign_generated_ipv6_cidr_block = "true"
   tags                             = "${var.tag}"
}

output "vpc01_id" {
   value = "${aws_vpc.vpc01.id}"
}
output "ipv6_cidr_block" {
   value = "${aws_vpc.vpc01.ipv6_cidr_block}"
}
