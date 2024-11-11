locals {
  nat_gw_count = var.one_natgw_per_az ? length(local.zones) : 1
}

resource "aws_eip" "nat_eip" {
  count  = local.nat_gw_count
  domain = "vpc"

  tags = {
    Name = "nat-gw-eip-${element(local.zones, count.index)}"
  }
}

resource "aws_nat_gateway" "my_natgw" {
  count = local.nat_gw_count

  allocation_id = element(aws_eip.nat_eip[*].id, count.index)
  subnet_id     = element(aws_subnet.public_subnet[*].id, count.index)

  tags = {
    Name = "nat-gw-${element(local.zones, count.index)}"
  }
}
