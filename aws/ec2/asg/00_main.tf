
#
# Variables
#
variable "ami_name" = { default = "amzn-ami*ecs-optimized" }
variable "instance_type" { default = "t2.micro" }
variable "availability_zones" []
variable "security_groups" []
variable "min_size" { default = 1 }
variable "max_size" { default = 1 }
variable "desired_capacity" { default = 1 }
variable "user_data_file" {}


variable "vpc" {}
variable "subnet" {}
variable "ssh_key" {}
#variable "iam_instance_profile" {}

data "aws_ami" "ecs" {
  most_recent = true

  owners = [ "amazon" ]

  filter {
    name   = "name"
    values = ["${var.ami_name}"]
  }

  filter {
     name = "root-device-type"
     values = [ "ebs" ]

  }

}

resource "aws_launch_configuration" "launch_conf" {
    #name_prefix = "terraform-lc-example-"
    image_id = "${data.aws_ami.ecs.id}"
    instance_type = "${var.instance_type}"
    user_data = "${file("${var.user_data_file}")}"

# TODO security_groups
}

resource "aws_autoscaling_group" "bar" {
    name = "terraform-asg-example-${aws_launch_configuration.launch_conf.name}"
    launch_configuration = "${aws_launch_configuration.launch_conf.name}"

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
