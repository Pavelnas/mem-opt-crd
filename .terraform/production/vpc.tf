resource "aws_vpc" "production-vpc" {
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = "${var.env}-vpc"
    environment = "${var.env}"
  }
}

output "vpc-id" {
  value = "${aws_vpc.production-vpc.id}"
}

resource "aws_subnet" "production-vpc-private-subnet-a" {
  vpc_id = "${aws_vpc.production-vpc.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone =  "eu-north-1a"
  tags = {
    Name = "${var.env}-private-subnet-a"
    environment = "${var.env}"
  }
}

resource "aws_subnet" "production-vpc-private-subnet-b" {
  vpc_id = "${aws_vpc.production-vpc.id}"
  cidr_block = "10.0.3.0/24"
  availability_zone =  "eu-north-1b"
  tags = {
    Name = "${var.env}-private-subnet-b"
    environment = "${var.env}"
  }
}

resource "aws_subnet" "production-vpc-public-subnet-a" {
  vpc_id = "${aws_vpc.production-vpc.id}"
  cidr_block = "10.0.2.0/24"
  availability_zone =  "eu-north-1a"
  tags = {
    Name = "${var.env}-public-subnet-a"
    environment = "${var.env}"
  }
}
resource "aws_subnet" "production-vpc-public-subnet-b" {
  vpc_id = "${aws_vpc.production-vpc.id}"
  cidr_block = "10.0.4.0/24"
  availability_zone =  "eu-north-1b"
  tags = {
    Name = "${var.env}-public-subnet-b"
    environment = "${var.env}"
  }
}

resource "aws_internet_gateway" "production-ig" {
  vpc_id = "${aws_vpc.production-vpc.id}"
  tags = {
    Name = "${var.env}-ig"
    environment = "${var.env}"
  }
}

resource "aws_egress_only_internet_gateway" "production-egress-ig" {
  vpc_id = "${aws_vpc.production-vpc.id}"

  tags = {
    Name = "${var.env}-egress-ig"
    environment = "${var.env}"
  }
}

resource "aws_route_table" "public-route-table" {
  vpc_id = "${aws_vpc.production-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.production-ig.id}"
  }

  tags = {
    Name = "${var.env}-public-route-table"
    environment = "${var.env}"
  }
}

resource "aws_route_table" "private-route-table" {
  vpc_id = "${aws_vpc.production-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.production-egress-ig.id}"
  }

  tags = {
    Name = "${var.env}-public-route-table"
    environment = "${var.env}"
  }
}

resource "aws_route_table_association" "public-route-table-association-a" {
  subnet_id      = "${aws_subnet.production-vpc-public-subnet-a.id}"
  route_table_id = "${aws_route_table.public-route-table.id}"
}

resource "aws_route_table_association" "public-route-table-association-b" {
  subnet_id      = "${aws_subnet.production-vpc-public-subnet-b.id}"
  route_table_id = "${aws_route_table.public-route-table.id}"
}

resource "aws_route_table_association" "private-route-table-association-a" {
  subnet_id      = "${aws_subnet.production-vpc-private-subnet-a.id}"
  route_table_id = "${aws_route_table.private-route-table.id}"
}

resource "aws_route_table_association" "private-route-table-association-b" {
  subnet_id      = "${aws_subnet.production-vpc-private-subnet-b.id}"
  route_table_id = "${aws_route_table.private-route-table.id}"
}