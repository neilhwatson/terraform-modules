variable "tag" { type = "map" }
variable "cidr_block" {}
variable "vpc_id" {}

resource "aws_subnet" "subnet01" {
   vpc_id                           = "{$var.vpc_id}"
   cidr_block                       = "${var.cidr_block}"
   assign_generated_ipv6_cidr_block = "true"
   tags                             = "${var.tag}"
}

output "cidr_block" {
   value = "${aws_subnet.subnet01.cidr_block}"
}
