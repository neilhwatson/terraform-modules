variable "tag" { type = "map" }
variable "cidr_block" {}
variable "ipv6_cidr_block" {}
variable "vpc_id" {}

resource "aws_subnet" "subnet01" {
   vpc_id          = "${var.vpc_id}"
   cidr_block      = "${var.cidr_block}"
   ipv6_cidr_block = "${var.ipv6_cidr_block}"
   tags            = "${var.tag}"
}

output "id" {
   value = "${aws_subnet.subnet01.id}"
}
output "cidr_block" {
   value = "${aws_subnet.subnet01.cidr_block}"
}
output "ipv6_cidr_block" {
   value = "${aws_subnet.subnet01.ipv6_cidr_block}"
}
