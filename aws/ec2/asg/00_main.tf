#
# Variables
#
variable "ami_id"              { }
variable "instance_type"       { default = "t2.micro" }
variable "vpc_zone_ids"        { type = list }
variable "security_groups"     { type = list }
variable "min_size"            { default = 1 }
variable "max_size"            { default = 2 }
variable "desired_capacity"    { default = 1 }
variable "user_data"           { }
variable "tag"                 { type = map }
variable "ssh_key"             { }
variable "instance_profile"    { }
variable "associate_public_ip" { default = "false" }
variable "asg_name"            { default = "default" }

#variable "iam_instance_profile" { }

resource "aws_launch_configuration" "launch_conf01" {
   image_id                    = var.ami_id
   instance_type               = var.instance_type
   user_data                   = var.user_data
   key_name                    = var.ssh_key
   security_groups             = var.security_groups
   iam_instance_profile        = var.instance_profile
   associate_public_ip_address = "true"
#    tags                      = var.tag

   lifecycle { create_before_destroy = true }
}

resource "aws_autoscaling_group" "asg01" {
   name                 = var.asg_name
   launch_configuration = aws_launch_configuration.launch_conf01.name
   vpc_zone_identifier  = var.vpc_zone_ids
   min_size             = var.min_size
   max_size             = var.max_size
   desired_capacity     = var.desired_capacity
#    tags                = var.tag

}
