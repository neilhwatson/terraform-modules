#
# Variables
#
variable "vpc" {}
variable "subnet" {}
variable "ssh_key" {}
#variable "iam_instance_profile" {}


data "aws_ami" "ecs" {
  most_recent = true

  owners = [ "amazon" ]

  filter {
    name   = "name"
    values = ["amzn-ami*ecs-optimized"]
  }

  filter {
     name = "root-device-type"
     values = [ "ebs" ]

  }

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
    Name = ""
    purpose = ""

  }
}

