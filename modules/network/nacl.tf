resource "aws_network_acl" "public-subnets-acl" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "${var.vpc_name}-public-subnets-acl"
  }
}

resource "aws_network_acl" "private-subnets-acl" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "${var.vpc_name}-private-subnets-acl"
  }
}

resource "aws_network_acl_rule" "public-subnets_acl_rules" {
  network_acl_id = aws_network_acl.public-subnets-acl.id

  for_each = { for rule_name, rule in var.subnets_acl["public"] : rule_name => rule }

  rule_number = each.value.rule_number
  egress      = each.value.egress
  cidr_block  = each.value.cidr_block
  protocol    = each.value.protocol
  from_port   = each.value.from_port
  to_port     = each.value.to_port
  rule_action = each.value.rule_action
}

resource "aws_network_acl_rule" "private-subnets_acl_rules" {
  network_acl_id = aws_network_acl.private-subnets-acl.id

  for_each = { for rule_name, rule in var.subnets_acl["private"] : rule_name => rule }

  rule_number = each.value.rule_number
  egress      = each.value.egress
  cidr_block  = each.value.cidr_block
  protocol    = each.value.protocol
  from_port   = each.value.from_port
  to_port     = each.value.to_port
  rule_action = each.value.rule_action
}

resource "aws_network_acl_association" "public_subnet_acl_association" {
  for_each       = toset([for pub_subnet in aws_subnet.public_subnet : pub_subnet.id])
  subnet_id      = each.value
  network_acl_id = aws_network_acl.public-subnets-acl.id
}

resource "aws_network_acl_association" "private_subnet_acl_association" {
  for_each       = toset([for priv_subnet in aws_subnet.private_subnet : priv_subnet.id])
  subnet_id      = each.value
  network_acl_id = aws_network_acl.private-subnets-acl.id
}
