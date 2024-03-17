# VPC
module "vpc" {
  source               = "./modules/vpc"
  private_subnets_cidr = var.public_subnets_cidr
  public_subnets_cidr  = var.private_subnets_cidr
  aws_region           = var.aws_region
  vpc_cidr             = var.vpc_cidr
  EnvName              = var.EnvName
}

# Security-Group
module "security_group" {
  source                 = "./modules/security_group"
  EnvName                = var.EnvName
  VpcId                  = module.vpc.vpc_id
  additional_cidr_blocks = []
}

# DB EC2 #
module "mysql_DB" {
  source        = "./modules/ec2"
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.AutoScalingGroup.apache_server.InstanceType
  mykey         = var.KeyPair
  subnet_ids  = module.vpc.private_subnets 
  ec2_secgp     = module.security_group.DBSecurityGroupId
  EnvName       = var.EnvName
  db_name = var.db_name
  dbusername = var.dbusername
  db_user_password = data.aws_ssm_parameter.db_password.value

}

# Apache Auto-Scaling #
module "autoscaling_group_apache" {
  source                  = "./modules/autoscaling_group"
  Settings                = var.AutoScalingGroup.apache_server
  EnvName                 = var.EnvName
  KeyPair                 = var.KeyPair
  AMI                     = data.aws_ami.ubuntu.id
  UserData                = data.template_file.webserver_user_data.rendered
  PublicSubnetId          = module.vpc.public_subnets
  InstanceSecurityGroupId = module.security_group.InstanceSecurityGroupId
  Name                    = "apache-webserver"
  TargetGroup             = [module.alb.target_group_arn]
}

# Load Balancer
module "alb" {
  source                      = "./modules/alb"
  EnvName                     = var.EnvName
  Settings                    = var.LoadBalancer
  PublicSubnetId              = module.vpc.public_subnets
  VpcId                       = module.vpc.vpc_id
  LoadBalancerSecurityGroupId = module.security_group.LoadBalancerSecurityGroupId
  autoscaling_group_name      = module.autoscaling_group_apache.aws_autoscaling_group_name
  autoscaling_id              = module.autoscaling_group_apache.aws_autoscaling_group_name
}

# dns
#module "dns" {
#  source           = "./modules/dns"
#  domain_name      = "*.exampletest.com"
#  environment_name = "Dev"
#  zone_name        = "exampletest.com"
#  record_name      = "cert.exampletest.com"
#  alias_name       = module.alb.alb.dns_name
#  alias_zone_id    = module.alb.alb.zone_id
#}

