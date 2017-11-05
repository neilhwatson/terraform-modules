variable "security_group_name" { default = "mydefault" }
variable "tag"                 { type = "map" }

resource "aws_security_group" "sg01" {
    name        = "${var.security_group_name}"
    description = "Default deny"
}

output "name" {
   value = "${aws_security_group.sg01.name}"
}
output "id" {
   value = "${aws_security_group.sg01.id}"
}
