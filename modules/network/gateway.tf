# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = var.vpc.id

  tags = { Name = "${var.stack_prefix}.main.igw" }
}

# NAT Gateway
resource "aws_eip" "ngw" {
  count = var.nat_gateway_num

  vpc = true

  tags = { Name = "${var.stack_prefix}.ngw-az-${var.subnets.public[count.index].az}.eip" }
}

resource "aws_nat_gateway" "main" {
  count = var.nat_gateway_num

  subnet_id     = aws_subnet.public[count.index].id
  allocation_id = aws_eip.ngw[count.index].id

  tags = { Name = "${var.stack_prefix}.az-${var.subnets.public[count.index].az}.ngw" }
}