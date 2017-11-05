# TODO not ready
#
# Variables
#
variable "vpc" {}
variable "subnet" {}
variable "ssh_key" {}
variable "ami" {}
variable "security_groups" { type = "list" default = [] }
variable "instance_type" { default = "t2.micro" }
#variable "iam_instance_profile" {}

# TODO security group for ssh and cfengine in

resource "aws_instance" "instance01" {
  ami           = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name      = "${var.ssh_key}"
  vpc_security_group_ids = "${security_groups}"
  subnet_id     = "${var.subnet}"
#  iam_instance_profile
# ipv6_address_count
# ipv6_addresses
  

  #user_data     =

  tags {
    Name = ""
    purpose = ""

  }
}

