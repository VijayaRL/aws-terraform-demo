vpc_cidr             = "10.0.0.0/16"
aws_region           = "us-east-1"
public_subnets_cidr  = ["10.0.0.0/24", "10.0.1.0/24"]
private_subnets_cidr = ["10.0.2.0/24", "10.0.3.0/24"]

AutoScalingGroup = {
  apache_server = {
    InstanceType           = "t2.micro"
    MinSize                = "1"
    MaxSize                = "2"
    DesiredCapacity        = "1"
    InstanceVolumeSize     = "30"
    HealthCheckGracePeriod = 300
    HealthCheckType        = "EC2"
    DefaultCooldown        = 300
  }
}


LoadBalancer = {

  TargetGroups = {
    apache_server = {
      HealthyThreshold   = 3
      UnhealthyThreshold = 10
      Timeout            = 10
      Interval           = 20
      HealthCheckPath    = "/"
      HealthCheckPort    = "80"
    }
  }
}



EnvName = "dev"
KeyPair = "demokeypair"





