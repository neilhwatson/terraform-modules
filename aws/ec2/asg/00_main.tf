#
# Variables
#
variable "ami_id"                { }
variable "instance_type"         { default = "t2.micro" }
variable "vpc_zone_ids"          { type = "list" }
variable "security_groups"       { type = "list" }
variable "min_size"              { default = 1 }
variable "max_size"              { default = 1 }
variable "desired_capacity"      { default = 1 }
variable "user_data_file"        { }
variable "tag"                   { type = "map" }
variable "ssh_key"               { }
#variable "iam_instance_profile" { }

resource "aws_launch_configuration" "launch_conf01" {
    image_id        = "${var.ami_id}"
    instance_type   = "${var.instance_type}"
    user_data       = "${file("${var.user_data_file}")}"
    key_name        = "${var.ssh_key}"
    security_groups = [ "${var.security_groups}" ]
    associate_public_ip_address = "true"
#    tags            = "${var.tag}"

}

resource "aws_autoscaling_group" "asg01" {
    launch_configuration = "${aws_launch_configuration.launch_conf01.name}"
    vpc_zone_identifier  = [ "${var.vpc_zone_ids}" ]
    min_size             = "${var.min_size}"
    max_size             = "${var.max_size}"
    desired_capacity     = "${var.desired_capacity}"
#    tags                = "${var.tag}"

}
