#Input access key
variable "aws_access_key" {
  default = "*****"
}
#Input secret key
variable "aws_secret_key" {
  default = "*****"
}

#Custom AMI to be used to launch instance
variable "ami" {
  default = "ami-03fe39565a14f2a28"
}

#set default region
variable "aws_region" {
  default = "us-east-1"
}

#EC2 instance name
variable "aws_instance_name" {
  default = "Test_EC2"
}


