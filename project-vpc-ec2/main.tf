resource "aws_vpc" "myvpc" {

 cidr_block = var.vpc_cidr

}

#Creating internet gateway
resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.myvpc.id
}


#Creating subnets
resource "aws_subnet" "Cir_blk" {

  count = length(var.subnet_cidrs)

  vpc_id    = aws_vpc.myvpc.id

  cidr_block = var.subnet_cidrs[count.index]

  availability_zone = var.availability_zone[count.index]

  map_public_ip_on_launch = var.map_public_ip_on_launch

}


#Creating Route Tables
resource "aws_route_table" "public_rtable" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = var.cidr_block
    gateway_id = var.gateway_id
  }
}


#Creating Subnet Association
resource "aws_route_table_association" "rta1" {
  count = length(var.subnet_cidrs)
  subnet_id      = aws_subnet.Cir_blk[count.index].id
  route_table_id = var.route_table_id


}

#Creating Security Groups
resource "aws_security_group" "webSg" {
  name   = var.wb
  vpc_id = aws_vpc.myvpc.id

  ingress {
    from_port   = var.port
    to_port     = var.port
    protocol    = var.sg_protocol
    cidr_blocks = var.cidr_blocks
  }
  ingress {
    description = var.ingress_des_type
    from_port   = var.ingress_port
    to_port     = var.ingress_port
    protocol    = var.sg_protocol
    cidr_blocks = var.cidr_blocks
  }

  egress {
    from_port   = var.egress_port
    to_port     = var.egress_port
    protocol    = var.egress_protocol
    cidr_blocks = var.cidr_blocks

  }

  tags = {
    Name = var.sg_name
  }
}


# Creating S3 Bucket
resource "aws_s3_bucket" "example" {
  bucket = var.bkt
}


resource "aws_instance" "webserver" {
  count = length(var.subnet_cidrs)
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.webSg.id]
  subnet_id              = aws_subnet.Cir_blk[count.index].id
  user_data = file("userdata.sh")
}

#create alb
resource "aws_lb" "myalb" {
  name               = var.lbname
  internal           = var.internal
  load_balancer_type = var.lb_type

  security_groups = [aws_security_group.webSg.id]
  subnets         = aws_subnet.Cir_blk[*].id

  tags = {
    Name = var.wb
  }
}



# Creating Load Balancer
resource "aws_lb_target_group" "tg" {
  name     = var.tg
  port     = var.port
  protocol = var.protocol
  vpc_id   = aws_vpc.myvpc.id

  health_check {
    path = var.Pathdir
    port = var.TP
  }
}

# Attaching Load Balancer
resource "aws_lb_target_group_attachment" "attach" {
  count = length(var.subnet_cidrs)
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.webserver[count.index].id
  port             = var.port

}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.myalb.arn
  port              = var.port
  protocol          = var.protocol

  default_action {
    target_group_arn = aws_lb_target_group.tg.arn
    type             = "forward"
  }
}
