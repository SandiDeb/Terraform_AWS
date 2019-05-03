resource "aws_vpc" "default" {
  cidr_block          = "10.0.0.0/16"
  enable_dns_hostname = true

  tags {
    name = "default"
  }
}

resource "aws_subnet" "terraform_subnet" {
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags {
    name = "terraform_subnet"
  }
}

resource "aws_internet_gateway" "teraform_gateway" {
  vpc_id = "${aws_vpc.default.id}"
}

resource "aws_route_table" "terraform-route_table" {
  vpc_id = "${aws_vpc.default.id}"
  route {
    cidr_block  = "0.0.0.0/0"
    gateway_id  = "${aws_internet_gateway.teraform_gateway.id}"
  }
}

resource "aws_route_table_association" "terraform_association" {
  subnet_id      = "${aws_subnet.terraform_subnet.id}"
  route_table_id = "${aws_route_table.teraform_gateway.id}"
}

resource "aws_security_group" "terraform_scgroup" {
  name   = "Terraform_Security_Group"
  vpc_id = "${aws_vpc.default.id}"

  ingress {
    from_port  = 22
    to_port    = 22
    protocol   = "tcp"
    cidr_block = "203.191.35.0/24"
  }

  egress {
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    cidr_block = "0.0.0.0/0"
  }
}
