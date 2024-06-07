# Create a VPC
resource "aws_vpc" "ziyo_vpc" {
  cidr_block = var.ziyo_vpc_cidr_block

  tags = var.ziyo_vpc_tag
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.ziyo_vpc.id

  tags = var.igw_tags
}

resource "aws_route_table" "ziyo_rt" {
  vpc_id = aws_vpc.ziyo_vpc.id

  route {
    cidr_block = var.rt_cidr
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = var.rt_tag
}

resource "aws_route_table_association" "ziyo_a" {
  subnet_id      = aws_subnet.ziyo_subnet_public.id
  route_table_id = aws_route_table.ziyo_rt.id
}

resource "aws_route_table_association" "ziyo_b" {
  subnet_id      = aws_subnet.ziyo_subnet_public2.id
  route_table_id = aws_route_table.ziyo_rt.id
}

## public subnets
resource "aws_subnet" "ziyo_subnet_public" {
  vpc_id            = aws_vpc.ziyo_vpc.id
  availability_zone = var.az_us-east-1a
  cidr_block        = var.pub_subnet1_cidr

  tags = var.pub_subnet1_tag
}

resource "aws_subnet" "ziyo_subnet_public2" {
  vpc_id            = aws_vpc.ziyo_vpc.id
  availability_zone = var.az_us-east-1b
  cidr_block        = var.pub_subnet2_cidr

  tags = var.pub_subnet2_tag
}

## private subnets
resource "aws_subnet" "ziyo_subnet_private1" {
  vpc_id            = aws_vpc.ziyo_vpc.id
  availability_zone = var.az_us-east-1c
  cidr_block        = var.prv_subnet1_cidr

  tags = var.prv_subnet1_tag
}

resource "aws_subnet" "ziyo_subnet_private2" {
  vpc_id            = aws_vpc.ziyo_vpc.id
  availability_zone = var.az_us-east-1d
  cidr_block        = var.prv_subnet2_cidr

  tags = var.prv_subnet2_tag
}
