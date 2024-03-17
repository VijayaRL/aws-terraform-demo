output "LoadBalancerSecurityGroupId" {
  value = aws_security_group.LoadBalancerSecurityGroup.id
}

output "InstanceSecurityGroupId" {
  value = aws_security_group.InstanceSecurityGroup.id
}

output "DBSecurityGroupId" {
  value = aws_security_group.DBSecurityGroup.id
}