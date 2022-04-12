resource "aws_route_table" "nat_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "nat-route-table"
  }
}

resource "aws_route_table" "internet_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "internet-route-table"
  }
}

# ASSOCIATE ROUTE TABLE -- PRIVATE_a LAYER . This association explains where data needs to go when is associated with a subnet
resource "aws_route_table_association" "internet_route_table_association_pvt_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.nat_route_table.id
}

# ASSOCIATE ROUTE TABLE -- PRIVATE_b LAYER
resource "aws_route_table_association" "internet_route_table_association_pvt_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.nat_route_table.id
}

# ASSOCIATE ROUTE TABLE -- DATA LAYER
resource "aws_route_table_association" "internet_route_table_association_data_a" {
  subnet_id      = aws_subnet.data_a.id
  route_table_id = aws_route_table.nat_route_table.id
}

# ASSOCIATE ROUTE TABLE -- DATA LAYER
resource "aws_route_table_association" "internet_route_table_association_data_b" {
  subnet_id      = aws_subnet.data_b.id
  route_table_id = aws_route_table.nat_route_table.id
}

# ASSOCIATE ROUTE TABLE -- PUBLIC LAYER
resource "aws_route_table_association" "internet_route_table_association_public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.internet_route_table.id
}

resource "aws_route_table_association" "internet_route_table_association_public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.internet_route_table.id
}