
output "target_group_arn" {
  value = aws_lb_target_group.this.arn
}


output "AlbDns" {
  value = aws_lb.alb.dns_name
}

output "ZoneId" {
  value = aws_lb.alb.zone_id
}