data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "template_file" "webserver_user_data" {
  template = templatefile("template/webserver_user_data.sh", {
  })
}

data "aws_ssm_parameter" "db_password" {
  name = "/database/db_password"
}

