#
# Variables
#
variable "ami_id" {}
variable "instance_type" { default = "t2.micro" }
variable "availability_zones" { type = "list" }
variable "security_groups" { type = "list" }
variable "min_size" { default = 1 }
variable "max_size" { default = 1 }
variable "desired_capacity" { default = 1 }
variable "user_data_file" {}


variable "vpc" {}
variable "subnet" {}
variable "ssh_key" {}
#variable "iam_instance_profile" {}

resource "aws_launch_configuration" "launch_conf01" {
    image_id        = "${var.ami_id}"
    instance_type   = "${var.instance_type}"
    user_data       = "${file("${var.user_data_file}")}"
    key_name        = "${var.ssh_key}"
    security_groups = "${var.security_groups}"

}

resource "aws_autoscaling_group" "asg01" {
    name = "terraform-asg-example-${aws_launch_conf01iguration.launch_conf01.name}"
    launch_conf01iguration = "${aws_launch_conf01iguration.launch_conf01.name}"

    availability_zones = "${var.availability_zones}"
    min_size = "${var.min_size}"
    max_size = "${var.max_size}"
    desired_capacity = "${var.desired_capacity}"

}
# TODO security group for ssh and cfengine in

resource "aws_instance" "web" {
  ami           = "${data.aws_ami.ecs.id}"
  instance_type = "t2.micro"
  key_name      = "${var.ssh_key}"
  #vpc_security_group_ids = 
  subnet_id     = "${var.subnet}"
#  iam_instance_profile
# ipv6_address_count
# ipv6_addresses
  

  #user_data     =

  tags {
    Name = "oort"
    purpose = "cfbot and ssh jump"

  }
}

