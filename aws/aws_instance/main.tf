variable "image_id" {}
variable "instance_type" { default = "t2.micro" }
variable "tag_name" { default = "undefined" }
variable "ssh_key" { default = "luna" }
variable "security_groups" { type = "list" }

resource "aws_instance" "instance01" {
  ami           = "${var.image_id}"
  instance_type = "${var.instance_type}"
  key_name      = "${var.ssh_key}"
  security_groups = [ "${var.security_groups}" ]

  tags {
    Name = "${var.tag_name}"
  }
}

resource "aws_eip" "eip01" { 
  vpc = true
  instance = "${aws_instance.instance01.id}"
}

output "eip_id" {
   value = "${aws_eip.eip01.id}"
}
output "eip" {
   value = "${aws_eip.eip01.public_ip}"
}
#resource "aws_eip_association" "eip_assoc" {
  #instance_id   = "${aws_instance.web.id}"
  #allocation_id = "${aws_eip.example.id}"
#}

# TODO assign static ipv6 or get the auto asigned one.
