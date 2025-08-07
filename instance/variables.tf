# variable "instance_type" {
#   type = string
#   default = "t3.micro"
# }

variable "instance_type" {
  type = map
  default = {
    "example" = "t3.micro",
    "otherinstance" = "t2.micro"
  }
}

variable "aws_region" {
  default = "us-east-1"
}