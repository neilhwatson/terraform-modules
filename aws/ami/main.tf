variable "architecture"        { default = "x86_64" }
variable "description"         { default = "*" }
variable "name"                { default = "Amazon Linux AMI*" }
variable "owner"               { default = "*" }
variable "root_device_type"    { default = "*" }
variable "virtualization_type" { default = "*" }

data "aws_ami" "ami01" {
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
      values = ["${var.root_device_type}"]
   }
   filter {
      name   = "virtualization_type"
      values = ["${var.virtualization_type}"]
   }
}

output "image_id" {
   value = "${data.aws_ami.ami01.image_id}"
}
