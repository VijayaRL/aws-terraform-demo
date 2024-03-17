resource "aws_security_group" "LoadBalancerSecurityGroup" {
  vpc_id      = var.VpcId
  name        = "${var.EnvName}-LoadBalancerSecurityGroup"
  description = "security group that allows all ingress and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.EnvName}-LoadBalancerSecurityGroup"
  }
}

resource "aws_security_group" "InstanceSecurityGroup" {
  vpc_id      = var.VpcId
  name        = "${var.EnvName}-InstanceSecurityGroup"
  description = "security group that allows all ingress and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = var.additional_cidr_blocks != null ? var.additional_cidr_blocks : null
    security_groups = [aws_security_group.LoadBalancerSecurityGroup.id]
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.EnvName}-InstanceSecurityGroup"
  }
}

resource "aws_security_group" "DBSecurityGroup" {
  vpc_id      = var.VpcId
  name        = "${var.EnvName}-DBInstanceSecurityGroup"
  description = "security group that allows all ingress and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = var.additional_cidr_blocks != null ? var.additional_cidr_blocks : null
    security_groups = [aws_security_group.LoadBalancerSecurityGroup.id]
  }

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks     = var.additional_cidr_blocks != null ? var.additional_cidr_blocks : null
    security_groups = [aws_security_group.LoadBalancerSecurityGroup.id]
  }

  tags = {
    Name = "${var.EnvName}-InstanceSecurityGroup"
  }
}


