variable "security_group_name" { default = "ssh-in" }
variable "tag"                 { type = "map" }
variable "vpc_id"              {}
variable "source_cidr_blocks" {
   type    = "list"
   default = [ "0.0.0.0/0" ]
}
variable "ipv6_source_cidr_blocks" {
   type    = "list"
   default = [ "::/0" ]
}

resource "aws_security_group" "sg01" {
    name        = "${var.security_group_name}"
    description = "SSH in ${var.security_group_name}"
    vpc_id      = "${var.vpc_id}"
    tags        = "${var.tag}"

    // allow traffic for TCP ssh
    ingress {
        from_port        = 22
        to_port          = 22
        protocol         = "tcp"
        cidr_blocks      = ["${var.source_cidr_blocks}"]
        ipv6_cidr_blocks = ["${var.ipv6_source_cidr_blocks}"]
    }
}

output "name" {
   value = "${aws_security_group.sg01.name}"
}
