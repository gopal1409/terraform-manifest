##we will define two input variable 
variable "region" {
  description = "region in which aws resource need to be created"
  type        = string #numerics tuples map
  default     = "us-east-1"
}

variable "instance_type" {
  description = "instance type"
  type        = string
  default     = "t3.micro"
}