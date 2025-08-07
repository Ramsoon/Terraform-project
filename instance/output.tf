output "public_ip" {
  value = aws_instance.myinstance.public_ip
  
}

output "public_subnets" {
  value = module.vpc.public_subnets
}