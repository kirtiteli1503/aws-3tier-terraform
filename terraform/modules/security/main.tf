# ALB: internet se HTTP
resource "aws_security_group" "alb" {
  name        = "${var.name}-alb-sg"
  description = "Allow HTTP from internet"
  vpc_id      = var.vpc_id
  tags        = { Name = "${var.name}-alb-sg" }
}

resource "aws_vpc_security_group_ingress_rule" "alb_http" {
  security_group_id = aws_security_group.alb.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "alb_all" {
  security_group_id = aws_security_group.alb.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# App: sirf ALB se traffic
resource "aws_security_group" "app" {
  name        = "${var.name}-app-sg"
  description = "Allow traffic from ALB only"
  vpc_id      = var.vpc_id
  tags        = { Name = "${var.name}-app-sg" }
}

resource "aws_vpc_security_group_ingress_rule" "app_from_alb" {
  security_group_id            = aws_security_group.app.id
  referenced_security_group_id = aws_security_group.alb.id
  from_port                    = var.app_port
  to_port                      = var.app_port
  ip_protocol                  = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "app_all" {
  security_group_id = aws_security_group.app.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# DB: sirf App se traffic
resource "aws_security_group" "db" {
  name        = "${var.name}-db-sg"
  description = "Allow DB traffic from app only"
  vpc_id      = var.vpc_id
  tags        = { Name = "${var.name}-db-sg" }
}

resource "aws_vpc_security_group_ingress_rule" "db_from_app" {
  security_group_id            = aws_security_group.db.id
  referenced_security_group_id = aws_security_group.app.id
  from_port                    = var.db_port
  to_port                      = var.db_port
  ip_protocol                  = "tcp"
}