# Create a simple instance inside the default VPC
#
# Variables
#
variable "ami"                 { }
variable "associate_public_ip" { default = "true" }
variable "instance_type"       { default = "t2.micro" }
variable "ipv6_count"          { default = 1 }
variable "profile"             { }
variable "ssh_key"             { }
variable "user_data_file"      { }
# Passing a map of tags does not work in TF. Waiting on improvement.
#variable "tags"                { type = "map" }

resource "aws_instance" "instance01" {
ami                         = "${var.ami}"
associate_public_ip_address = "${var.associate_public_ip}"
iam_instance_profile        = "${var.profile}"
instance_type               = "${var.instance_type}"
ipv6_address_count          = "${var.ipv6_count}"
key_name                    = "${var.ssh_key}"
user_data                   = "${file("${var.user_data_file}")}"
}

output "name" {
   value = "${aws_instance.instance01.public_dns}"
}
