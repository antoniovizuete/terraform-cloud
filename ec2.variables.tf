variable "ec2_specs" {
  description = "EC2 instance specifications"
  type = object({
    ami           = string
    instance_type = string
  })
}
