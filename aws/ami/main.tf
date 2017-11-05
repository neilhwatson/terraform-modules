variable "architecture" { default = "x86_64" }
variable "size"         { default = "*"          }
variable "description"  { default = "Amazon Linux AMI*" }
variable "owner"        { default = "*" }

data "aws_ami" "nat_ami" {
   most_recent = true
   owners = [ "${var.owner}" ]

   filter {
      name   = "architecture"
      values = ["${var.architecture}"]
   }
#   filter {
#      name   = "block-device-mapping.volume-size"
#      values = ["${var.size}"]
#   }
#   filter {
#      name   = "description"
#      values = ["${var.description}"]
#   }
}

output "image_id" {
   value = "${data.aws_ami.nat_ami.image_id}"
}
