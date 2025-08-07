
resource "aws_instance" "myinstance" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type.example
  subnet_id = module.vpc.public_subnet_objects[0]

  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  key_name = aws_key_pair.mykey.key_name
  tags = {
    Name = "myec2"
  }
} 

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "allow_tls"
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 22
    to_port          = 22 
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_key_pair" "mykey" {
  key_name   = "myec2-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDpbrKPv/pqEVSEoMIs85qKwUZneq5rdWcxxkQsczvnZengKbBgFMZmgjh3MiTO6rbwctt4Iccl+CFJagHxZ2758O2cAwxGAp2UVAffuLcH38+q/DbWYR4ySGhvYEaUs7TW0ppiFb0sUr79fS5mdbr+EbeBFO/WFbLNVzDpvhnuqe3+zrhWZNzhlj37IOYcJSoLZevGXbqXcXOyozHxDpFrsMr18rYeZPODbEH0N2qqwgAdQwYrH9pqFz1Pz9bHI30W+DWf3L8p4AB1bHU/hlJIarNB8c93fM8M60EBiSyaYnmYc2nWbksvoHZq/ncBLWs1ZwgDBnoqqtf7KpCeGOwJUiieRJO2QT3a+z4gDL1gC5ixPVu3Z2F5DP6kMiAQezYEwYHN2H18cd+BOTTf3nYXgvilc5m4iDO6m1iIWZxOeJnXNA7xqa0/OPiY7it47jDlz9illIMSt2CriPaytoQ9Xgk8xG22PYswEPi47Bz2eLSWF+eCTsbut7aHlOIXjyE="
}
 