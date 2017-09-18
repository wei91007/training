#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-1d4e7a66
#
# Your subnet ID is:
#
#     subnet-77f9d52d
#
# Your security group ID is:
#
#     sg-e72efe94
#
# Your Identity is:
#
#     terraform-slug
#

terraform {
  backend "atlas" {
    name = "Wei91007/training"
  }
}
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  # ...
  count      = "${var.num_webs}"
  ami = "ami-1d4e7a66"
  instance_type = "t2.micro"

  subnet_id              = "subnet-77f9d52d"
  vpc_security_group_ids = ["sg-e72efe94"]

  tags {
    "Identity" = "terraform-slug"
    "myOwnTag" = "wei"
    "myOwner" = "wei"
    "Name" = "web ${count.index + 1}/${var.num_webs}"
  }
}

output "public_ip" {
  value = ["${aws_instance.web.public_ip}"]
}
output "public_dns" {
  value = ["${aws_instance.web.public_dns}"]
}

