resource "aws_eip" "vpc_iep" {
  domain = "vpc"
  tags = {
    Name = "${var.cluster_name}-eip"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.vpc_iep.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "${var.cluster_name}-nat-gateway"
  }
}

resource "aws_route_table" "nat" {
  vpc_id = aws_vpc.cluster_vpc.id

  tags = {
    Name = "${var.cluster_name}-private-route"
  }
}

resource "aws_route" "nat_access" {
  route_table_id         = aws_route_table.nat.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}
