
resource "aws_instance" "ec2" {

  ami           = var.ami
  instance_type = var.instance_type
  key_name        = var.mykey
  security_groups = [var.ec2_secgp]
  subnet_id = element(var.subnet_ids, 0)

  tags = {
    key   = "Name"
    value = "${var.EnvName}-Database-Instance"
  }

  user_data =   <<EOF
#!/bin/bash
sudo su
sudo yum install mariadb-server -y
sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo mysqladmin -u root password '${var.db_user_password}'
sudo mysqladmin -uroot -p${var.db_user_password} create '${var.db_name}'
sudo mysql -uroot -p${var.db_user_password} -e "CREATE USER '${var.dbusername}'@'%' IDENTIFIED BY '${var.db_user_password}';"
sudo mysql -uroot -p${var.db_user_password} -e "GRANT ALL PRIVILEGES ON ${var.db_name}.* TO '${var.dbusername}'@'%';"
sudo mysql -uroot -p${var.db_user_password} -e "FLUSH PRIVILEGES;"
EOF
}



