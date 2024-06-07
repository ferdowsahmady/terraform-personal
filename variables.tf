variable "ssh_key" {
  type        = string
  default     = "ferro-key"
  description = "ferro's AWS ssh-key"
}

variable "ec2_ami_id" {
  type    = string
  default = "ami-07caf09b362be10b8"
}

variable "instance_type" {
  description = "assign value for instance compute"
  type        = string
  default     = "t2.micro"
}

variable "associate_public_ip_address" {
  type    = bool
  default = true
  # nullable = false
}

variable "ebs_optimize" {
  type    = bool
  default = null
}

variable "s3_tag" {
  type = map(any)
  default = {
    Name        = "My bucket "
    Environment = "Dev"
  }
}

variable "ec2_type" {
  type    = string
  default = "t2.micro"
}

variable "az" {
  type    = string
  default = "us-east-1a"

}

# s3 vars 
variable "s3_bucket_name" {
  default = "fer-ziyotek-bucket"
  type    = string
}

variable "bucket_force_destroy" {
  type    = bool
  default = true
}

variable "sse_algorithm" {
  default = "AES256"
}

variable "block_public_acls" {
  type    = bool
  default = false
}

variable "block_public_policy" {
  type    = bool
  default = false
}

variable "ignore_public_acls" {
  type    = bool
  default = false
}

variable "restrict_public_buckets" {
  type    = bool
  default = false
}

variable "s3_bucket_acl" {
  type    = string
  default = "public-read"
}

variable "s3_bucket_ownership_controls" {
  type    = string
  default = "BucketOwnerPreferred"
}

variable "aws_s3_bucket_versioning" {
  type    = string
  default = "Enabled"
}

variable "s3_bucket_object_lock" {
  type    = string
  default = "Enabled"
}

variable "default_retention_days" {
  type    = number
  default = 5
}

variable "object_lock_mode" {
  type    = string
  default = "COMPLIANCE"
}

variable "ec2_key" {
  type    = string
  default = "ferro-key"
}

variable "ec2_monitoring" {
  type    = bool
  default = true
}

variable "ebs_optimization" {
  type    = bool
  default = true
}

variable "ec2_tag1" {
  type = map(any)
  default = {
    Name = "web_server1"
  }
}

## vpc vars
variable "ziyo_vpc_cidr_block" {
  type    = string
  default = "10.10.0.0/16"
}

variable "ziyo_vpc_tag" {
  type = map(any)
  default = {
    Terraform = "true"
    Name      = "ziyo_vpc"
  }
}

variable "igw_tags" {
  type = map(any)
  default = {
    name      = "ziyo_igw"
    Terraform = "true"
  }

}

variable "rt_cidr" {
  type    = string
  default = "0.0.0.0/0"
}

variable "rt_tag" {
  type = map(any)
  default = {
    Terraform = "true"
    Name      = "ziyo-rt"
  }
}

#Security Group
variable "aws_security_group" {
  type    = string
  default = "ziyo_security_group"
}

variable "ziyo_sg_tag" {
  type = map(any)
  default = {
    Terraform = "true"
    Name      = "ziyo-2024"
  }
}

variable "sg_cidr_ipv4" {
  type    = string
  default = "0.0.0.0/0"

}

variable "port" {
  type    = number
  default = 22
}

variable "tcp_protocol" {
  type    = string
  default = "tcp"

}
variable "allow_ssh" {
  type = map(any)
  default = {
    Name = "allow_ssh"
  }
}

variable "port_postgre" {
  type    = number
  default = "5432"
}

variable "allow_postgre" {
  type = map(any)
  default = {
    Name = "allow_postgre"

  }
}

variable "egress_ip" {
  type    = number
  default = "-1" # semantically equivalent to all ports
}

variable "egress_tag" {
  type = map(any)
  default = {
    Name = "allow_all_outbound_traffic"
  }
}

## subnet vars
variable "az_us-east-1a" {
  type    = string
  default = "us-east-1a"
}

variable "pub_subnet1_cidr" {
  type    = string
  default = "10.10.1.0/24"
}

variable "pub_subnet1_tag" {
  type = map(any)
  default = {
    Terraform = "True"
    Name      = "Public_subnet_1"
  }
}

variable "az_us-east-1b" {
  type    = string
  default = "us-east-1b"
}

variable "pub_subnet2_cidr" {
  type    = string
  default = "10.10.2.0/24"
}

variable "pub_subnet2_tag" {
  type = map(any)
  default = {
    Terraform = "True"
    Name      = "Public_subnet_2"
  }
}

variable "az_us-east-1c" {
  type    = string
  default = "us-east-1c"
}

variable "prv_subnet1_cidr" {
  type    = string
  default = "10.10.3.0/24"
}

variable "prv_subnet1_tag" {
  type = map(any)
  default = {
    Terraform = "True"
    Name      = "Private_subnet_1"
  }
}

variable "az_us-east-1d" {
  type    = string
  default = "us-east-1d"
}

variable "prv_subnet2_cidr" {
  type    = string
  default = "10.10.4.0/24"
}

variable "prv_subnet2_tag" {
  type = map(any)
  default = {
    Terraform = "True"
    Name      = "Private_subnet_2"
  }
}


##RDS VARS

variable "environment_name" {
  type = string
  nullable = false
}

variable "db_name" {
  type    = string
  default = "ziyotekdb"
}

variable "allocated_storage" {
  type  = number
  default = 10
  nullable = false
}

variable "db_engine" {
  type    = string
  default = "mariadb"
}

variable "engine_version" {
  type    = string
  default = "10.11.6"
}

variable "instance_class" {
  type    = string
  default = "db.t3.micro"
  
}

variable "db_username" {
  type    = string
  default = "ziyo_user"
}

variable "parameter_group_name" {
  type    = string
  default = "default.mariadb10.11"

}
variable "skip_final_snapshot" {
  type    = bool
  default = true

}

variable "storage_type" {
  type    = string
  nullable = false
}

variable "ssm_PS_name" {
  type    = string
  default = "studentdb-pass"
}


variable "subnet_ids" {
  type        = list(string)
  default     = []
}

variable "vpc_security_group" {
  type = list
  default = []
}
