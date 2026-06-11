variable "vpc_cidr" {
  type = string
}

variable "subnet_cidrs" {
  type = list(string)
}
variable "availability_zone" {
  type = list(string)
}

variable "map_public_ip_on_launch" {
  type = bool
}

variable "ig_name" {
  type = string
}

variable "cidr_block" {
  type = string
}

variable "gateway_id" {
  type = string
}

variable "subnet_id" {
  type = list(string)
}

variable "route_table_id" {
  type = string
}

variable "wb" {
  type = string
}

variable "bkt" {
  type = string
}

variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "lbname" {
  type = string
}

variable "lb_type" {
  type = string
}

variable "internal" {
  type = bool
}

variable "tg" {
  type = string
}

variable "port" {
  type = string
}

variable "protocol" {
  type = string
}

variable "TP" {
  type = string
}

variable "Pathdir" {
  type = string
}


variable "type" {
  type = string
}

variable "sg_protocol" {
  type = string
}

variable "ingress_des_type" {
  type = string
}

variable "ingress_port" {
  type = string
}

variable "egress_port" {
  type = string
}

variable "ingress_protocol" {
  type = string
}

variable "sg_name" {
  type = string
}

variable "egress_protocol" {
  type = string
}

variable "cidr_blocks" {
  type = list(string)
}
