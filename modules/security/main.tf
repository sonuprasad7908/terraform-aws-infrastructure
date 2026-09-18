locals {
  common_tags = merge(
    var.tags,
    {
      ManagedBy = "Terraform"
    }
  )

  alb_rules = {
    for pair in setproduct(var.alb_ingress_ports, var.alb_ingress_cidrs) :
    "${pair[0]}-${replace(pair[1], "/", "-")}" => {
      port = pair[0]
      cidr = pair[1]
    }
  }
}

resource "aws_security_group" "alb" {
  name_prefix = "${var.name}-alb-"
  description = "Security group for the application load balancer"
  vpc_id      = var.vpc_id

  tags = merge(
    local.common_tags,
    {
      Name = "${var.name}-alb-sg"
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_ingress_rule" "alb" {
  for_each = local.alb_rules

  security_group_id = aws_security_group.alb.id
  description       = "Allow TCP ${each.value.port} from ${each.value.cidr}"

  cidr_ipv4   = each.value.cidr
  from_port   = each.value.port
  to_port     = each.value.port
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "alb" {
  security_group_id = aws_security_group.alb.id
  description       = "Allow outbound traffic from the load balancer"

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

resource "aws_security_group" "application" {
  name_prefix = "${var.name}-app-"
  description = "Security group for application instances"
  vpc_id      = var.vpc_id

  tags = merge(
    local.common_tags,
    {
      Name = "${var.name}-app-sg"
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_ingress_rule" "application_from_alb" {
  security_group_id = aws_security_group.application.id
  description       = "Allow application traffic only from the load balancer"

  referenced_security_group_id = aws_security_group.alb.id

  from_port   = var.application_port
  to_port     = var.application_port
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "application" {
  security_group_id = aws_security_group.application.id
  description       = "Allow outbound traffic from application instances"

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}
