variable "ireland_cidr" {
  description = "Ireland VPC CIDR block"
  type        = string
}

# variable "public_subnet_cidr" {
#   description = "Public subnet CIDR block"
#   type        = string
# }

# variable "private_subnet_cidr" {
#   description = "Private subnet CIDR block"
#   type        = string
# }

variable "subnets" {
  description = "Subnets CIDR blocks"
  type        = list(string)
}

variable "sg_ingress_cidr" {
  description = "CIDR block to allow SSH access to the public instance"
  type        = string
}

variable "ingress_port_list" {
  description = "List of ports to allow inbound traffic"
  type        = list(number)
}
