module "vpc" {
  source                 = "terraform-aws-modules/vpc/aws"
  cidr                   = var.vpc_cidr
  azs                    = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
  public_subnets         = var.public_subnets_cidr
  private_subnets        = var.private_subnets_cidr
  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false
  tags = {
    key   = "Name"
    value = "${var.EnvName}-VPC"
  }
}

