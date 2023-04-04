resource "aws_vpc" "cairo-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "terra-cairo"
  }
}

resource "aws_subnet" "cairo-pub-1" {
  vpc_id                  = aws_vpc.cairo-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1
  tags = {
    Name = "cairo-pub-1"
  }
}

resource "aws_subnet" "cairo-pub-2" {
  vpc_id                  = aws_vpc.cairo-vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE2
  tags = {
    Name = "cairo-pub-2"
  }
}

resource "aws_subnet" "cairo-pub-3" {
  vpc_id                  = aws_vpc.cairo-vpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE3
  tags = {
    Name = "cairo-pub-3"
  }
}

resource "aws_subnet" "cairo-priv-1" {
  vpc_id                  = aws_vpc.cairo-vpc.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1
  tags = {
    Name = "cairo-priv-1"
  }
}

resource "aws_subnet" "cairo-priv-2" {
  vpc_id                  = aws_vpc.cairo-vpc.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE2
  tags = {
    Name = "cairo-priv-2"
  }
}

resource "aws_subnet" "cairo-priv-3" {
  vpc_id                  = aws_vpc.cairo-vpc.id
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE3
  tags = {
    Name = "cairo-priv-3"
  }
}

resource "aws_internet_gateway" "cairo-IGW" {
  vpc_id = aws_vpc.cairo-vpc.id
  tags = {
    Name = "cairo-IGW"
  }
}

resource "aws_route_table" "cairo-pub-RT" {
  vpc_id = aws_vpc.cairo-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cairo-IGW.id
  }

  tags = {
    Name = "cairo-pub-RT"
  }
}

resource "aws_route_table_association" "cairo-pub-1-a" {
  subnet_id      = aws_subnet.cairo-pub-1.id
  route_table_id = aws_route_table.cairo-pub-RT.id
}

resource "aws_route_table_association" "cairo-pub-2-a" {
  subnet_id      = aws_subnet.cairo-pub-2.id
  route_table_id = aws_route_table.cairo-pub-RT.id
}

resource "aws_route_table_association" "cairo-pub-3-a" {
  subnet_id      = aws_subnet.cairo-pub-3.id
  route_table_id = aws_route_table.cairo-pub-RT.id
}