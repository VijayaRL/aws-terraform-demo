variable "EnvName" {}
variable "VpcId" {}
variable "additional_cidr_blocks" {
  type = list(string)
}