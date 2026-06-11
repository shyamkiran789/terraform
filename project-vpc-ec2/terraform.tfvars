vpc_cidr = "192.168.0.0/16"

subnet_cidrs = ["192.168.1.0/24", "192.168.2.0/24"]

availability_zone = ["ap-south-1a", "ap-south-1b"]

map_public_ip_on_launch = true

ig_name = "my_tera_gateway"

cidr_block = "0.0.0.0/0"

gateway_id = "aws_internet_gateway.igw.id"

subnet_id = ["aws_subnet.sub1.id", "aws_subnet.sub2.id"]

route_table_id = "aws_route_table.RT.id"

wb = "web"

bkt = "terraform_res_bkt"

ami = "ami-02b8269d5e85954ef"

instance_type = "t3.micro"

lbname = "myalb"

internal = false

lb_type = "application"

tg = "myTg"

port = "80"

protocol = "HTTP"

Pathdir = "/"

TP = "traffic-port"

type = "forward"

sg_protocol = "tcp"

ingress_des_type = "SSH"

ingress_port = "22"

ingress_protocol = "tcp"

egress_port = "0"

egress_protocol = "-1"

sg_name  = "Web-sg"


cidr_blocks = ["0.0.0.0/0"]
