variable "architecture"        { default = "x86_64" }
variable "description"         { default = "*" }
variable "name"                { default = "Amazon Linux AMI*" }
variable "owner"               { default = "*" }
variable "root-device-type"    { default = "*" }
variable "virtualization-type" { default = "*" }

data "aws_ami" "nat_ami" {
   most_recent = true

   filter {
      name   = "architecture"
      values = ["${var.architecture}"]
   }
   filter {
      name = "description"
      values = [ "${var.description}" ]
   }
   filter {
      name = "name"
      values = [ "${var.name}" ]
   }
   
   owners = [ "${var.owner}" ]

   filter {
      name   = "root_device_type"
      values = ["${var.root-device-type}"]
   }
   filter {
      name   = "virtualization_type"
      values = ["${var.virtualization-type}"]
   }
}

output "image_id" {
   value = "${data.aws_ami.nat_ami.image_id}"
}
