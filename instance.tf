# Configure the AWS Provider
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}

#Lauch EC2 with the following resources
resource "aws_instance" "Test_EC2" {
  ami                         = var.ami
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.Test_sg.id]
  subnet_id                   = aws_subnet.Testsub_pub.id
  associate_public_ip_address = true
  user_data = "${file("install_httpd.sh")}"
  tags = {
    Name = "${var.aws_instance_name}"
  }
}


