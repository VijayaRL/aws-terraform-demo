variable "AutoScalingGroup" {}
variable "LoadBalancer" {}
variable "EnvName" {}
variable "aws_region" {}
variable "KeyPair" {}

variable "private_subnets_cidr" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "public_subnets_cidr" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "vpc_cidr" {
  description = "cidr of VPC"
  type        = string
}

variable "dbusername" {
  description = "Username for the DB"
  type        = string
  default     = "testuser"
}
variable "db_name" {
  description = "Name of the DB Created"
  type        = string
  default     = "demodatabase"
}