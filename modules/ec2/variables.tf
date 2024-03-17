variable "ami" {}

variable "instance_type" {}

variable "subnet_ids" {
  type    = list(string)
  default = []
}

variable "mykey" {}

variable "ec2_secgp" {}


variable "EnvName" {}

variable "dbusername" {
  description = "Username for the DB"
  type        = string
}

variable "db_name" {
  description = "Name of the DB Created"
  type        = string
}

variable "db_user_password" {
  description = "Name of the DB Created"
  type        = string
}