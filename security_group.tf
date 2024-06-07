resource "aws_security_group" "ziyo_security_group" {
  name   = var.aws_security_group
  vpc_id = aws_vpc.ziyo_vpc.id

  tags = var.ziyo_sg_tag
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.ziyo_security_group.id
  cidr_ipv4         = var.sg_cidr_ipv4
  from_port         = var.port
  ip_protocol       = var.tcp_protocol
  to_port           = var.port

  tags = var.allow_ssh
}

resource "aws_vpc_security_group_ingress_rule" "allow_postgres" {
  security_group_id = aws_security_group.ziyo_security_group.id
  cidr_ipv4         = aws_vpc.ziyo_vpc.cidr_block
  from_port         = var.port_postgre
  ip_protocol       = var.tcp_protocol
  to_port           = var.port_postgre

  tags = var.allow_postgre
}

resource "aws_vpc_security_group_egress_rule" "allow_outbound_traffic" {
  security_group_id = aws_security_group.ziyo_security_group.id
  cidr_ipv4         = var.sg_cidr_ipv4
  ip_protocol       = var.egress_ip

  tags = var.egress_tag
}