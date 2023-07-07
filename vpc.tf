# VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "main"
  }
}

# 퍼블릭 서브넷1 WEB1
resource "aws_subnet" "public_sub_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-northeast-2a"

  tags = {
    Name = "public_sub_1"
  }
}

#퍼블릿 서브넷2 WEB2
resource "aws_subnet" "public_sub_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-northeast-2c"

  tags = {
    Name = "public_sub_2"
  }
}

#프라이빗 서브넷1 WAS1
resource "aws_subnet" "private_sub_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-northeast-2a"

  tags = {
    Name = "main-private-1"
  }
}

#프라이빗 서브넷2 WAS2
resource "aws_subnet" "private_sub_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-northeast-2c"

  tags = {
    Name = "main-private-2"
  }
}

#프라이빗 서브넷3 RDS
resource "aws_subnet" "private_sub_RDS_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-northeast-2a"

  tags = {
    Name = "main-private-RDS-1"
  }
}

# Internet GW
resource "aws_internet_gateway" "main-gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

# public 라우팅 테이블
resource "aws_route_table" "main_public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-gw.id
  }

  tags = {
    Name = "main_public_1"
  }
}

# 퍼플릭 라우팅 연결 수정해야될듯
resource "aws_route_table_association" "main_public_1a" {
  subnet_id      = aws_subnet.public_sub_1.id
  route_table_id = aws_route_table.main_public.id
}

resource "aws_route_table_association" "main_public_2a" {
  subnet_id      = aws_subnet.public_sub_2.id
  route_table_id = aws_route_table.main_public.id
}

resource "aws_alb" "public_alb" {
  name = "pubic_alb"
  subnets = ["${aws_subnet.public_sub_1}", "${aws_subnet.public_sub_2}"]

}