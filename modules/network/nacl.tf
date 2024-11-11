resource "aws_network_acl" "public_subnets_acl" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "${var.vpc_name}-public-subnets-acl"
  }
}

resource "aws_network_acl" "private_subnets_acl" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "${var.vpc_name}-private-subnets-acl"
  }
}

resource "aws_network_acl_rule" "public_inbound" {
  network_acl_id = aws_network_acl.public_subnets_acl.id
  count          = length(var.public_inbound_acl_rules)

  egress      = false
  rule_number = var.public_inbound_acl_rules[count.index]["rule_number"]
  cidr_block  = var.public_inbound_acl_rules[count.index]["cidr_block"]
  protocol    = var.public_inbound_acl_rules[count.index]["protocol"]
  from_port   = var.public_inbound_acl_rules[count.index]["from_port"]
  to_port     = var.public_inbound_acl_rules[count.index]["to_port"]
  rule_action = var.public_inbound_acl_rules[count.index]["rule_action"]
}

resource "aws_network_acl_rule" "public_outbound" {
  network_acl_id = aws_network_acl.public_subnets_acl.id
  count          = length(var.public_outbound_acl_rules)

  egress      = true
  rule_number = var.public_outbound_acl_rules[count.index]["rule_number"]
  cidr_block  = var.public_outbound_acl_rules[count.index]["cidr_block"]
  protocol    = var.public_outbound_acl_rules[count.index]["protocol"]
  from_port   = var.public_outbound_acl_rules[count.index]["from_port"]
  to_port     = var.public_outbound_acl_rules[count.index]["to_port"]
  rule_action = var.public_outbound_acl_rules[count.index]["rule_action"]
}

resource "aws_network_acl_rule" "private_inbound" {
  network_acl_id = aws_network_acl.private_subnets_acl.id
  count          = length(var.private_inbound_acl_rules)

  egress      = false
  rule_number = var.private_inbound_acl_rules[count.index]["rule_number"]
  cidr_block  = var.private_inbound_acl_rules[count.index]["cidr_block"]
  protocol    = var.private_inbound_acl_rules[count.index]["protocol"]
  from_port   = var.private_inbound_acl_rules[count.index]["from_port"]
  to_port     = var.private_inbound_acl_rules[count.index]["to_port"]
  rule_action = var.private_inbound_acl_rules[count.index]["rule_action"]
}

resource "aws_network_acl_rule" "private_outbound" {
  network_acl_id = aws_network_acl.private_subnets_acl.id
  count          = length(var.private_outbound_acl_rules)

  egress      = true
  rule_number = var.private_outbound_acl_rules[count.index]["rule_number"]
  cidr_block  = var.private_outbound_acl_rules[count.index]["cidr_block"]
  protocol    = var.private_outbound_acl_rules[count.index]["protocol"]
  from_port   = var.private_outbound_acl_rules[count.index]["from_port"]
  to_port     = var.private_outbound_acl_rules[count.index]["to_port"]
  rule_action = var.private_outbound_acl_rules[count.index]["rule_action"]
}

resource "aws_network_acl_association" "public_subnet_acl_association" {
  for_each       = toset([for pub_subnet in aws_subnet.public_subnet : pub_subnet.id])
  subnet_id      = each.value
  network_acl_id = aws_network_acl.public_subnets_acl.id
}

resource "aws_network_acl_association" "private_subnet_acl_association" {
  for_each       = toset([for priv_subnet in aws_subnet.private_subnet : priv_subnet.id])
  subnet_id      = each.value
  network_acl_id = aws_network_acl.private_subnets_acl.id
}
