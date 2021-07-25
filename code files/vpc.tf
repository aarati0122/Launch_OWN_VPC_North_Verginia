resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "lwterra"
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "myigw TF"
  }
}


resource "aws_security_group" "mysg" {
  vpc_id      = aws_vpc.main.id

   ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
	#cidr_blocks      = [aws_vpc.main.cidr_block]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    #cidr_blocks = ["0.0.0.0/0"]
	cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  
  tags = {
	Name = "Security Group TF"
  }
}


resource "aws_security_group_rule" "rule" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  security_group_id = aws_security_group.mysg.id
}

resource "aws_subnet" "main" {
  #count = length(var.subnets_cidr)
  vpc_id     = aws_vpc.main.id
  #cidr_block = element( var.subnets_cidr,  count.index  )
  #availability_zone = element( var.azs , count.index )
  cidr_block = var.subnets_cidr
  availability_zone = var.azs 
  map_public_ip_on_launch = true
  tags = {
    #Name = "Subnet-${count.index + 1}"
	Name  ="Subnet-1"
  }
}

resource "aws_route_table" "routetable" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }


  tags = {
    Name = "MyRouteTable"
  }
}



resource "aws_route_table_association" "a" {
  #count = length(var.subnets_cidr)
  #subnet_id      = element(aws_subnet.main.*.id, count.index)
  subnet_id = aws_subnet.main.id
  route_table_id = aws_route_table.routetable.id
}



