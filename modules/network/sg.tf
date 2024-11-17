locals {
  default_public_sg_inbound_rules = [
    {
      cidr_ipv4   = "0.0.0.0/0"
      ip_protocol = "icmp"
      from_port   = -1
      to_port     = -1
    },
    {
      cidr_ipv4   = "0.0.0.0/0"
      ip_protocol = "tcp"
      from_port   = 22
      to_port     = 22
    },
  ]

  default_public_sg_outbound_rules = [
    {
      cidr_ipv4   = "0.0.0.0/0"
      ip_protocol = "all"
      from_port   = -1
      to_port     = -1
    }
  ]

  default_private_sg_inbound_rules = concat(
    [for admin_ip in var.admin_ips :
      {
        cidr_ipv4   = admin_ip
        ip_protocol = "icmp"
        from_port   = -1
        to_port     = -1
      }
    ],
    [for admin_ip in var.admin_ips :
      {
        cidr_ipv4   = admin_ip
        ip_protocol = "tcp"
        from_port   = 22
        to_port     = 22
      }
    ],
    [
      {
        cidr_ipv4   = var.vpc_cidr
        ip_protocol = "all"
        from_port   = -1
        to_port     = -1
      }
    ]
  )

  default_private_sg_outbound_rules = [
    {
      cidr_ipv4   = "0.0.0.0/0"
      ip_protocol = "all"
      from_port   = -1
      to_port     = -1
    }
  ]


  all_public_sg_inbound_rules   = length(var.public_sg_inbound) == 0 ? local.default_public_sg_inbound_rules : var.public_sg_inbound
  all_public_sg_outbound_rules  = length(var.public_sg_outbound) == 0 ? local.default_public_sg_outbound_rules : var.public_sg_outbound
  all_private_sg_inbound_rules  = length(var.private_sg_inbound) == 0 ? local.default_private_sg_inbound_rules : var.private_sg_inbound
  all_private_sg_outbound_rules = length(var.private_sg_outbound) == 0 ? local.default_private_sg_outbound_rules : var.private_sg_outbound
}

resource "aws_security_group" "public_instance_sg" {
  vpc_id = aws_vpc.main_vpc.id
  name   = "sg for instances in public subnets used for testing network connectivity"
}

resource "aws_vpc_security_group_ingress_rule" "public_instance_sg_rule_ingress" {
  security_group_id = aws_security_group.public_instance_sg.id

  count = length(local.all_public_sg_inbound_rules)

  cidr_ipv4   = local.all_public_sg_inbound_rules[count.index]["cidr_ipv4"]
  ip_protocol = local.all_public_sg_inbound_rules[count.index]["ip_protocol"]
  from_port   = local.all_public_sg_inbound_rules[count.index]["from_port"]
  to_port     = local.all_public_sg_inbound_rules[count.index]["to_port"]
}

resource "aws_vpc_security_group_egress_rule" "public_instance_sg_rule_egress" {
  security_group_id = aws_security_group.public_instance_sg.id

  count = length(local.all_public_sg_outbound_rules)

  cidr_ipv4   = local.all_public_sg_outbound_rules[count.index]["cidr_ipv4"]
  ip_protocol = local.all_public_sg_outbound_rules[count.index]["ip_protocol"]
  from_port   = local.all_public_sg_outbound_rules[count.index]["from_port"]
  to_port     = local.all_public_sg_outbound_rules[count.index]["to_port"]
}

resource "aws_security_group" "private_instance_sg" {
  vpc_id = aws_vpc.main_vpc.id
  name   = "sg for instances in private subnets used for testing network connectivity"
}

resource "aws_vpc_security_group_ingress_rule" "private_instance_sg_rule_ingress" {
  security_group_id = aws_security_group.private_instance_sg.id

  count = length(local.all_private_sg_inbound_rules)

  cidr_ipv4   = local.all_private_sg_inbound_rules[count.index]["cidr_ipv4"]
  ip_protocol = local.all_private_sg_inbound_rules[count.index]["ip_protocol"]
  from_port   = local.all_private_sg_inbound_rules[count.index]["from_port"]
  to_port     = local.all_private_sg_inbound_rules[count.index]["to_port"]
}

resource "aws_vpc_security_group_egress_rule" "private_instance_sg_rule_egress" {
  security_group_id = aws_security_group.private_instance_sg.id

  count = length(local.all_private_sg_outbound_rules)

  cidr_ipv4   = local.all_private_sg_outbound_rules[count.index]["cidr_ipv4"]
  ip_protocol = local.all_private_sg_outbound_rules[count.index]["ip_protocol"]
  from_port   = local.all_private_sg_outbound_rules[count.index]["from_port"]
  to_port     = local.all_private_sg_outbound_rules[count.index]["to_port"]
}
