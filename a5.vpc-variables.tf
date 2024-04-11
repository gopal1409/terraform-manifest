variable "region" {
  type    = string
  default = "us-east-1"

}
variable "cidr" {
  type      = string
  default = "10.20.20.0/26"
}
variable "subnet_cidr_private" {
  type    = list(any)
  default = ["10.20.20.0/28", "10.20.20.16/28", "10.20.20.32/28"]
}

variable "availability_zone" {
    ###terraform if you do not define the varaible type by default terraform take that as string list
  default = ["us-east-1a","us-east-1b","us-east-1c"]
}
