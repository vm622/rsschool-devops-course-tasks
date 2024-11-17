locals {
  default_route_table_list = [
    {
      destination_cidr_block = aws_vpc.main_vpc.cidr_block
      gateway_id             = "local"
    }
  ]
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  dynamic "route" {
    for_each = concat(
      local.default_route_table_list,
      var.public_route_table_list,
      [
        {
          destination_cidr_block = "0.0.0.0/0"
          gateway_id             = aws_internet_gateway.my_igw.id
        }
      ]
    )
    content {
      cidr_block = route.value.destination_cidr_block
      gateway_id = route.value.gateway_id
    }
  }

  tags = {
    name = "public-route-table-igw"
    type = "network"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  dynamic "route" {
    for_each = concat(
      local.default_route_table_list,
      var.private_route_table_list,
      [
        {
          destination_cidr_block = "0.0.0.0/0"
          gateway_id             = aws_nat_gateway.my_natgw[0].id
        }
      ]
    )
    content {
      cidr_block = route.value.destination_cidr_block
      gateway_id = route.value.gateway_id
    }
  }

  tags = {
    name = "private-route-table-igw"
    type = "network"
  }
}

resource "aws_route_table_association" "public_subnet_assoc" {
  for_each       = toset([for pub_subnet in aws_subnet.public_subnet : pub_subnet.id])
  subnet_id      = each.value
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_subnet_assoc" {
  for_each       = toset([for priv_subnet in aws_subnet.private_subnet : priv_subnet.id])
  subnet_id      = each.value
  route_table_id = aws_route_table.private_route_table.id
}
