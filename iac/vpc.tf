resource "aws_vpc" "wiliot_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "Wiliot-VPC"
  }
}

resource "aws_subnet" "wiliot_subnet1" {
  map_public_ip_on_launch = true
  vpc_id            = aws_vpc.wiliot_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = "Wiliot-Subnet1"
  }
}

resource "aws_subnet" "wiliot_subnet2" {
  vpc_id            = aws_vpc.wiliot_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-west-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "Wiliot-Subnet2"
  }
}

resource "aws_internet_gateway" "wiliot_gw" {
  vpc_id = aws_vpc.wiliot_vpc.id
  tags = {
    Name = "Wiliot-IGW"
  }
}

resource "aws_route_table" "wiliot_route_table" {
  vpc_id = aws_vpc.wiliot_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wiliot_gw.id
  }

  tags = {
    Name = "Wiliot-RouteTable"
  }
}

resource "aws_route_table_association" "wiliot_rta1" {
  subnet_id      = aws_subnet.wiliot_subnet1.id
  route_table_id = aws_route_table.wiliot_route_table.id
}

resource "aws_route_table_association" "wiliot_rta2" {
  subnet_id      = aws_subnet.wiliot_subnet2.id
  route_table_id = aws_route_table.wiliot_route_table.id
}
