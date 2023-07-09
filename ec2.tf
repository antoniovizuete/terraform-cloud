variable "instances_name" {
  description = "Name of the EC2 instances"
  type        = set(string)
  default     = ["apache"]
}

resource "aws_instance" "public_instance" {
  for_each               = var.instances_name
  ami                    = var.ec2_specs.ami
  instance_type          = var.ec2_specs.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = data.aws_key_pair.my_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
  user_data              = file("scripts/userdata.sh")
  tags = {
    Name        = "${each.value}-${local.suffix}"
    Environment = "dev"
  }
}

