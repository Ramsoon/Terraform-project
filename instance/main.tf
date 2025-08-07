
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
  public_key = file("${path.module}/mykey.pub")

}

 
