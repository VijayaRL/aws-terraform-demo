resource "aws_lb" "alb" {
  name                       = "${var.EnvName}-ALB"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [var.LoadBalancerSecurityGroupId]
  subnets                    = var.PublicSubnetId
  enable_deletion_protection = false
}

# creating target group for wordpress #
resource "aws_lb_target_group" "this" {
  name       = "${var.EnvName}-TargetGroup"
  port       = "80"
  protocol   = "HTTP"
  vpc_id     = var.VpcId
  depends_on = [aws_lb.alb]
  health_check {
    healthy_threshold   = var.Settings.TargetGroups.apache_server.HealthyThreshold
    unhealthy_threshold = var.Settings.TargetGroups.apache_server.UnhealthyThreshold
    timeout             = var.Settings.TargetGroups.apache_server.Timeout
    interval            = var.Settings.TargetGroups.apache_server.Interval
    path                = var.Settings.TargetGroups.apache_server.HealthCheckPath
    port                = var.Settings.TargetGroups.apache_server.HealthCheckPort
    matcher             = "200-400"
  }
}

# Attaching target group to Asg #
resource "aws_autoscaling_attachment" "this" {
  autoscaling_group_name = var.autoscaling_group_name
  lb_target_group_arn    = aws_lb_target_group.this.arn
}

# create Listner for the TG #
resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn

  }
}

# Create a new ALB Target Group attachment
resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = var.autoscaling_id
  lb_target_group_arn    = aws_lb_target_group.this.arn
}
