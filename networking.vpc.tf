resource "aws_vpc" "vpc_ireland" {
  cidr_block = var.ireland_cidr
  tags = {
    Name = "vpc_ireland"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc_ireland.id
  cidr_block              = var.subnets[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc_ireland.id
  cidr_block = var.subnets[1]
  tags = {
    Name        = "private_subnet"
    Environment = var.tags["Environment"]
  }
  depends_on = [aws_subnet.public_subnet]
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc_ireland.id
  tags = {
    Name = "VPC Internet Gateway"
  }
}

resource "aws_route_table" "public_table_route_ireland" {
  vpc_id = aws_vpc.vpc_ireland.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "Table Route Public"
  }
}

resource "aws_route_table_association" "public_table_association_ireland" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_table_route_ireland.id
}

resource "aws_security_group" "sg_public_instance" {
  name        = "Public Instance Security Group"
  description = "Allow SSH inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.vpc_ireland.id
  dynamic "ingress" {
    for_each = var.ingress_port_list
    content {
      description = "Allow ${ingress.value} inbound traffic"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.sg_ingress_cidr]
    }
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Public Instance Security Group"
  }
}
