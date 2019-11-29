variable "architecture"        { default = "x86_64" }
variable "description"         { default = "*" }
variable "owner"               { default = "*" }
variable "root_device_type"    { default = "*" }
variable "virtualization_type" { default = "*" }

data "aws_ami" "ami01" {
   most_recent = true

   filter {
      name   = "architecture"
      values = [var.architecture]
   }
   filter {
      name = "description"
      values = [ var.description ]
   }
   
   owners = [ var.owner ]

   filter {
      name   = "root-device-type"
      values = [var.root_device_type]
   }
   filter {
      name   = "virtualization-type"
      values = [var.virtualization_type]
   }
}

output "image_id" {
   value = data.aws_ami.ami01.image_id
}
