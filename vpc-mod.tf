resource "aws_vpc" "main" {
  cidr_block = "192.168.0.0/16"

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

resource "aws_eip" "nat_eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id     = aws_eip.nat_eip.id
  connectivity_type = "public"
  subnet_id         = aws_subnet.public_a.id

  tags = {
    Name = "${var.project_name}-nat-gw"

  }

  depends_on = [aws_internet_gateway.igw]
}

# Separated the Subnets from this VPC files