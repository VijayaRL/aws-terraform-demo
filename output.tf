output "Load_balancer_DNS" {
  description = "The DNS string of the ALB"
  value       = module.alb.AlbDns
}

