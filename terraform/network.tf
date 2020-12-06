#
# Network
#

# Public Subnet
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.interview.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = var.availabilty_zone
}

resource "aws_internet_gateway" "interview" {
  vpc_id = aws_vpc.interview.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.interview.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.interview.id
  }
}

resource "aws_route_table_association" "public" {
  subnet_id       = aws_subnet.public.id
  route_table_id  = aws_route_table.public.id
}

resource "aws_security_group" "interview" {
  name        = "interview_sg"
  description = "Interview Security Group"
  vpc_id      = aws_vpc.interview.id

  // allow ssh
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // allow http
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Private Nated Subnet
resource "aws_subnet" "private_nated" {
  vpc_id            = aws_vpc.interview.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.availabilty_zone
}

resource "aws_eip" "nat_gw_eip" {
  vpc = true
}

resource "aws_nat_gateway" "gw" {
  allocation_id = aws_eip.nat_gw_eip.id
  subnet_id     = aws_subnet.public.id
}

resource "aws_route_table" "interview_rt" {
  vpc_id = aws_vpc.interview.id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.gw.id
  }

  tags = {
    Name = "Main Route Table for NAT-ed subnet"
  }
}

resource "aws_route_table_association" "interview_rta" {
  subnet_id       = aws_subnet.private_nated.id
  route_table_id  = aws_route_table.interview_rt.id
}

# Fully Private Subnet
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.interview.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = var.availabilty_zone
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.interview.id
}

resource "aws_route_table_association" "private_interview_rta" {
  subnet_id       = aws_subnet.private.id
  route_table_id  = aws_route_table.private_rt.id
}
