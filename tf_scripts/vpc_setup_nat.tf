resource "aws_route_table" "main-private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name = "vpc-private-1"
  }
}
# route mapping for private subnet
resource "aws_route_table_association" "vpc-private-1-a" {
  subnet_id = aws_subnet.vpc-private-1.id
  route_table_id = aws_route_table.main-private.id
}
resource "aws_route_table_association" "vpc-private-2-a" {
  subnet_id = aws_subnet.vpc-private-2.id
  route_table_id = aws_route_table.main-private.id
}
resource "aws_route_table_association" "vpc-private-3-a" {
  subnet_id = aws_subnet.vpc-private-3.id
  route_table_id = aws_route_table.main-private.id
}