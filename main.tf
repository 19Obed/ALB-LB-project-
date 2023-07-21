#aws networking

resource "aws_vpc" "Lezuha-VPC" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "Lezuha-VPC"
  }
}

#public subnets

resource "aws_subnet" "Lezuha-pub-subnet1" {
  vpc_id            = aws_vpc.Lezuha-VPC.id
  availability_zone = "eu-west-2b"
  cidr_block        = "10.0.1.0/24"

  tags = {
    Name = "Lezuha-pub-subnet1"
  }
}

resource "aws_subnet" "Lezuha-pub-subnet2" {
  vpc_id            = aws_vpc.Lezuha-VPC.id
  availability_zone = "eu-west-2a"
  cidr_block        = "10.0.2.0/24"

  tags = {
    Name = "Lezuha-pub-subnet2"
  }
}


#private subnet 

resource "aws_subnet" "Lezuha-priv-subnet1" {
  vpc_id            = aws_vpc.Lezuha-VPC.id
  availability_zone = "eu-west-2c"
  cidr_block        = "10.0.3.0/24"

  tags = {
    Name = "Lezuha-priv-subnet1"
  }
}

#public route table 

resource "aws_route_table" "Lezuha-public-route" {
  vpc_id = aws_vpc.Lezuha-VPC.id

  tags = {
    Name = "Lezuha-public-route"
  }
}

resource "aws_route_table" "Lezuha-private-route" {
  vpc_id = aws_vpc.Lezuha-VPC.id

  tags = {
    Name = "Lezuha-private-route"
  }
}


#associating public subnet to route table

resource "aws_route_table_association" "Lezuha-public-RTA" {
  subnet_id      = aws_subnet.Lezuha-pub-subnet1.id
  route_table_id = aws_route_table.Lezuha-public-route.id
}

resource "aws_route_table_association" "Lezuha-public-RTA-2" {
  subnet_id      = aws_subnet.Lezuha-pub-subnet2.id
  route_table_id = aws_route_table.Lezuha-public-route.id
}


#associating private subnet to route table

resource "aws_route_table_association" "Lezuha-private-RTA" {
  subnet_id      = aws_subnet.Lezuha-priv-subnet1.id
  route_table_id = aws_route_table.Lezuha-private-route.id
}

#internet gateway

resource "aws_internet_gateway" "Lezuha-IGW" {
  vpc_id = aws_vpc.Lezuha-VPC.id

  tags = {
    Name = "main"
  }
}


#associating route table with internet gateway

resource "aws_route_table_association" "Lezuha-IGW-association" {
  gateway_id     = aws_internet_gateway.Lezuha-IGW.id
  route_table_id = aws_route_table.Lezuha-public-route.id
}

data "aws_vpc" "foo" {
  default = true
}

output "foo" {
  value = data.aws_vpc.foo
}