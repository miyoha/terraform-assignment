# Create a VPC
resource "aws_vpc" "Test_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Test_vpc"
  }
}

#Add subnet public
resource "aws_subnet" "Testsub_pub" {
  vpc_id                  = aws_vpc.Test_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "Testsub_pub"
  }
}

#Add subnet Private
resource "aws_subnet" "Testsub_priv" {
  vpc_id     = aws_vpc.Test_vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "Testsub_priv"
  }
}

#Add internet gateway
resource "aws_internet_gateway" "Test_ig" {
  vpc_id = aws_vpc.Test_vpc.id

  tags = {
    Name = "Test_ig"
  }
}

#Add route table
resource "aws_route_table" "Test_rt" {
  vpc_id = aws_vpc.Test_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Test_ig.id
  }

  tags = {
    Name = "Test_rt"
  }
}

#Associate route table with Testsub_pub
resource "aws_route_table_association" "Test_pub" {
  subnet_id      = aws_subnet.Testsub_pub.id
  route_table_id = aws_route_table.Test_rt.id
}

#Associate route table with Testsub_priv
resource "aws_route_table_association" "Test_priv" {
  subnet_id      = aws_subnet.Testsub_priv.id
  route_table_id = aws_route_table.Test_rt.id
}

#Add Security group
resource "aws_security_group" "Test_sg" {
  name        = "Test_sg"
  description = "Allow only ssh and http inbound traffic"
  vpc_id      = aws_vpc.Test_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Test_sg"
  }
}

