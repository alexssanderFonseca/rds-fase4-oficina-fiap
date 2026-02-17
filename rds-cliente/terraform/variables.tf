variable "vpc_id" {
  type    = string
  default = "vpc-0d5c5beb43c622dad"
}

variable "subnets_id" {
  type    = list(any)
  default = ["subnet-021d8e75c16edd046", "subnet-0dfef100a893bd41d", "subnet-0b104464d5c84553c"]

}