resource "aws_subnet" "public_subnet" {
  count             = length(var.public_subnets)
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = element(local.zones, count.index)

  tags = {
    Name = "${var.vpc_name}-public-subnet-${count.index + 1}-${element(local.zones, count.index)}"
  }
}


resource "aws_subnet" "private_subnet" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = element(local.zones, count.index)

  tags = {
    Name = "${var.vpc_name}-private-subnet-${count.index + 1}-${element(local.zones, count.index)}"
  }
}
