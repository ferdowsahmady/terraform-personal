# locals {
#   employer_name_suffix = "netflix-2024"
# }

# resource "aws_db_instance" "default" {
#   allocated_storage      = var.allocated_storage
#   db_name                = "${var.environment_name}-${var.db_name}-${local.employer_name_suffix}"
#   engine                 = var.db_engine
#   engine_version         = var.engine_version
#   instance_class         = var.instance_class
#   username               = var.db_username
#   password               = var.db_password
#   parameter_group_name   = var.parameter_group_name
#   skip_final_snapshot    = var.skip_final_snapshot
#   db_subnet_group_name   = var.db_subnet_group_name
#   vpc_security_group_ids = var.vpc_security_group
#   storage_type           = var.storage_type

#   tags = {
#     name =  "${var.db_name}-${local.employer_name_suffix}" 
#     environment   = var.environment_name
#     }   
# }
# resource "aws_db_subnet_group" "ziyo_netg" {
#   name       = "${var.environment_name}-${local.employer_name_suffix}-db-netgroup"
#   subnet_ids = var.subnet_ids

# }

# resource "random_password" "password" {
#   length  = 10
#   special = false
# }

# resource "aws_ssm_parameter" "ssm-password" {
#   name  = "${var.ssm_PS_name}-${var.environment_name}-${local.employer_name_suffix}"
#   type  = "SecureString"
#   value = random_password.password.result
#   # key_id = data.aws_kms_key.by_alias.id

#     tags = {
#     name =  "${var.db_name}-${local.employer_name_suffix}" 
#     environment   = var.environment_name
#     }  
# }
