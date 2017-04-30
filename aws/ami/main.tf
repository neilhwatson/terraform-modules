variable "architecture" { default = "x86_64" }
variable "size"         { default = "8"          }
variable "description"  { default = "Amazon Linux AMI*" }

data "aws_ami" "nat_ami" {
   most_recent = true
   owners = ["self","amazon"]

   filter {
      name   = "architecture"
      values = ["${var.architecture}"]
   }
   filter {
      name   = "block-device-mapping.volume-size"
      values = ["${var.size}"]
   }
   filter {
      name   = "description"
      values = ["${var.description}"]
   }
}

output "image_id" {
   value = "${data.aws_ami.nat_ami.image_id}"
}
