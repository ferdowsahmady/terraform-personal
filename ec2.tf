resource "aws_instance" "web_server1" {
  ami                         = var.ec2_ami_id
  subnet_id                   = aws_subnet.ziyo_subnet_public.id
  vpc_security_group_ids      = [aws_security_group.ziyo_security_group.id]
  associate_public_ip_address = var.associate_public_ip_address
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.rsa-key-deployer.key_name
  ebs_optimized               = var.ebs_optimize
  secondary_private_ips       = null
  availability_zone           = var.az
  #iam_instance_profile       = aws_iam_instance_profile.test_profile.id
}

## TF resource, NOT AWS -just creates key in backend
resource "tls_private_key" "rsa-4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

## AWS creates the SSH Key with this. Must add "public_key_openssh" at the end 
resource "aws_key_pair" "rsa-key-deployer" {
  key_name   = "fer-private-RSA-key"
  public_key = tls_private_key.rsa-4096.public_key_openssh
}

## Pushing the RSA Key to SSM PS. Must add "private_key_pem" at the end  
resource "aws_ssm_parameter" "rsa-private-ssh-key" {   
  name  = "fer-private-RSA-key"                        
  type  = "SecureString"                              
  value = tls_private_key.rsa-4096.private_key_pem     
}






# resource "tls_private_key" "ed25519-ssh-key" {
#   algorithm = "ED25519" 
# }

# resource "aws_key_pair" "deployer-ed25519-key" {
#   key_name   = "fer-ed25519-private-key"
#   public_key = tls_private_key.ed25519-ssh-key.public_key_openssh
# }

# resource "aws_ssm_parameter" "ed25519-ssh-key" {
#   name  = "fer-ed25519-private-key"
#   type  = "SecureString"
#   value = tls_private_key.rsa-4096.private_key_pem
# }