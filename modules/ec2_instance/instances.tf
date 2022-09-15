resource "aws_instance" "IaC_ec2" {
  ami                = var.image
  instance_type      = var.instance_type
  key_name           = var.key_pair
  security_groups    = var.security_groups
  subnet_id          = var.subnet_id

  user_data = <<EOF
#!/bin/bash
sudo yum update -y
                sudo yum update -y
                sudo yum install httpd -y
                sudo service httpd start
                chkconfig httpd on
                cd /var/www/html
                sudo su
                echo "<html><body>Hola soy Héctor Vargas y esto es mi IaC </body></html>" > index.html
                cat index.html
                exit
EOF
  tags = {
    Name = "IaC_ec2"
  }
}