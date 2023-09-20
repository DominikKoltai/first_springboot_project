resource "aws_vpc" "aws_ec2_vpc" {
  cidr_block           = "192.168.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "aws-ec2-vpc"
  }
}

resource "aws_subnet" "aws_ec2_subnet" {
  vpc_id                  = aws_vpc.aws_ec2_vpc.id
  cidr_block              = "192.168.0.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-west-1a"

  tags = {
    Name = "aws-ec2-subnet"
  }
}

resource "aws_internet_gateway" "aws_ec2_gw" {
  vpc_id = aws_vpc.aws_ec2_vpc.id

  tags = {
    Name = "aws-ec2-gw"
  }
}

resource "aws_route_table" "aws_ec2_route_table" {
  vpc_id = aws_vpc.aws_ec2_vpc.id

  tags = {
    Name = "aws-ec2-route-table"
  }
}

resource "aws_route" "aws_ec2_internet_access" {
  route_table_id         = aws_route_table.aws_ec2_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.aws_ec2_gw.id
}

resource "aws_route_table_association" "aws_ec2_association" {
  subnet_id      = aws_subnet.aws_ec2_subnet.id
  route_table_id = aws_route_table.aws_ec2_route_table.id
}