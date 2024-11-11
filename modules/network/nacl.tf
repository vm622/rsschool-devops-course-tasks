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

locals {
  default_acl_rules = [
    {
      rule_number = 100
      cidr_block  = "0.0.0.0/0"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      rule_action = "allow"
    }
  ]

  all_public_inbound_acl_rules   = length(var.public_inbound_acl_rules) == 0 ? local.default_acl_rules : var.public_inbound_acl_rules
  all_public_outbound_acl_rules  = length(var.public_outbound_acl_rules) == 0 ? local.default_acl_rules : var.public_outbound_acl_rules
  all_private_inbound_acl_rules  = length(var.private_inbound_acl_rules) == 0 ? local.default_acl_rules : var.private_inbound_acl_rules
  all_private_outbound_acl_rules = length(var.private_outbound_acl_rules) == 0 ? local.default_acl_rules : var.private_outbound_acl_rules
}

resource "aws_network_acl_rule" "public_inbound" {
  network_acl_id = aws_network_acl.public_subnets_acl.id
  count          = length(local.all_public_inbound_acl_rules)

  egress      = false
  rule_number = local.all_public_inbound_acl_rules[count.index]["rule_number"]
  cidr_block  = local.all_public_inbound_acl_rules[count.index]["cidr_block"]
  protocol    = local.all_public_inbound_acl_rules[count.index]["protocol"]
  from_port   = local.all_public_inbound_acl_rules[count.index]["from_port"]
  to_port     = local.all_public_inbound_acl_rules[count.index]["to_port"]
  rule_action = local.all_public_inbound_acl_rules[count.index]["rule_action"]
}

resource "aws_network_acl_rule" "public_outbound" {
  network_acl_id = aws_network_acl.public_subnets_acl.id
  count          = length(local.all_public_outbound_acl_rules)

  egress      = true
  rule_number = local.all_public_outbound_acl_rules[count.index]["rule_number"]
  cidr_block  = local.all_public_outbound_acl_rules[count.index]["cidr_block"]
  protocol    = local.all_public_outbound_acl_rules[count.index]["protocol"]
  from_port   = local.all_public_outbound_acl_rules[count.index]["from_port"]
  to_port     = local.all_public_outbound_acl_rules[count.index]["to_port"]
  rule_action = local.all_public_outbound_acl_rules[count.index]["rule_action"]
}

resource "aws_network_acl_rule" "private_inbound" {
  network_acl_id = aws_network_acl.private_subnets_acl.id
  count          = length(local.all_private_inbound_acl_rules)

  egress      = false
  rule_number = local.all_private_inbound_acl_rules[count.index]["rule_number"]
  cidr_block  = local.all_private_inbound_acl_rules[count.index]["cidr_block"]
  protocol    = local.all_private_inbound_acl_rules[count.index]["protocol"]
  from_port   = local.all_private_inbound_acl_rules[count.index]["from_port"]
  to_port     = local.all_private_inbound_acl_rules[count.index]["to_port"]
  rule_action = local.all_private_inbound_acl_rules[count.index]["rule_action"]
}

resource "aws_network_acl_rule" "private_outbound" {
  network_acl_id = aws_network_acl.private_subnets_acl.id
  count          = length(local.all_private_outbound_acl_rules)

  egress      = true
  rule_number = local.all_private_outbound_acl_rules[count.index]["rule_number"]
  cidr_block  = local.all_private_outbound_acl_rules[count.index]["cidr_block"]
  protocol    = local.all_private_outbound_acl_rules[count.index]["protocol"]
  from_port   = local.all_private_outbound_acl_rules[count.index]["from_port"]
  to_port     = local.all_private_outbound_acl_rules[count.index]["to_port"]
  rule_action = local.all_private_outbound_acl_rules[count.index]["rule_action"]
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
