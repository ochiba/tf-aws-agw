data "aws_vpc" "main" {
  id = var.vpc.id
}

resource "aws_subnet" "public" {
  count = length(var.subnets.public)

  vpc_id            = var.vpc.id
  availability_zone = "${var.region.name}${var.subnets.public[count.index].az}"
  cidr_block        = var.subnets.public[count.index].cidr

  tags = { Name = "${var.stack_prefix}.pub-${var.subnets.public[count.index].az}.subnet" }
}

resource "aws_subnet" "private" {
  count = length(var.subnets.private)

  vpc_id            = var.vpc.id
  availability_zone = "${var.region.name}${var.subnets.private[count.index].az}"
  cidr_block        = var.subnets.private[count.index].cidr

  tags = { Name = "${var.stack_prefix}.prv-${var.subnets.private[count.index].az}.subnet" }
}