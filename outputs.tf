output "instance_id" {
  value = aws_instance.web_server1.id
}

output "instance_public_IP" {
  value = aws_instance.web_server1.public_ip
}

output "instance_private_IP" {
  value = aws_instance.web_server1.private_ip
}


