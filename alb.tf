locals {
  app_name    = var.my_var
  description = "${local.app_name}-ziyotek"
  my_local_tags = {
    name = "${local.app_name}-ziyotek"
  }
}

variable "my_var" { default = "web_tier" }

# # resource "aws_launch_configuration" "ziyo_lc" {
# #   name                        = local.app_name
# #   image_id                    = data.aws_ami.example.image_id
# #   instance_type               = "t2.micro"
# #   associate_public_ip_address = true
# #   security_groups = [
# #     aws_security_group.ziyo_security_group.id,
# #   ]
# #   user_data = file("efs-web.sh")
# #   key_name  = data.aws_key_pair.example.key_name
# # }

# resource "aws_launch_template" "foo" {
#   name = "${local.app_name}-launch-cong"
#   image_id = data.aws_ami.example.image_id
#   instance_type = "t2.micro"
#   key_name = data.aws_key_pair.example.key_name
  
# network_interfaces {
#     associate_public_ip_address = true
#     security_groups = [aws_security_group.ziyo_security_group.id]
#   }
#   user_data = filebase64("efs-web.sh")
#   vpc_security_group_ids = [
#     aws_security_group.ziyo_security_group.id
#   ]
#}

# resource "aws_autoscaling_group" "bar" {
#   name                 = "${local.app_name}-asg"
#   max_size             = 3
#   min_size             = 1
#   desired_capacity     = 1
#   force_delete         = false
  # based on the template option, choose between the next 2 arguments:
  # launch_configuration = aws_launch_configuration.ziyo_lc.name
#   launch_template {
#     id      = aws_launch_template.foo.id
#     version = "$Latest"
#   }
#   vpc_zone_identifier  = [aws_subnet.ziyo_subnet_public.id]
# }

# resource "aws_lb_target_group" "web_tg" {
#   name     = "${local.app_name}-tg"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.ziyo_vpc.id

#   health_check {
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#     timeout             = 5
#     interval            = 10
#     path                = "/"
#     port                = "traffic-port"
#     matcher             = "200-300"
#   }
# }

# # Create a new ALB Target Group attachment
# resource "aws_autoscaling_attachment" "web_attach" {
#   autoscaling_group_name = aws_autoscaling_group.bar.id
#   lb_target_group_arn    = aws_lb_target_group.web_tg.arn
# }

# resource "aws_lb" "web_tier_alb" {
#   name               = "${local.app_name}-lb"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.ziyo_security_group.id]
#   subnets            = [
#     aws_subnet.ziyo_subnet_public.id,
#     aws_subnet.ziyo_subnet_public_2.id
# ]

#   enable_deletion_protection = false
# }

# resource "aws_lb_listener" "web-lb-listener" {
#   load_balancer_arn = aws_lb.web_tier_alb.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.web_tg.arn
#   }
# }

# resource "aws_lb_listener_rule" "web" {
#   listener_arn = aws_lb_listener.web-lb-listener.arn
#   priority     = 100

#   action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.web_tg.arn
#   }

#   condition {
#     path_pattern {
#       values = ["/web*"]
#     }
#   }
# }

# ################################################

# resource "aws_lb_target_group" "static_tg" {
#   name     = "${local.app_name}-tg-static"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.ziyo_vpc.id

#   health_check {
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#     timeout             = 5
#     interval            = 10
#     path                = "/"
#     port                = "traffic-port"
#     matcher             = "200-300"
#   }
# }

# resource "aws_lb_target_group_attachment" "test" {
#   target_group_arn = aws_lb_target_group.static_tg.arn
#   target_id        = aws_instance.web_server1.id
#   port             = 80
# }

# resource "aws_lb_listener_rule" "static" {
#   listener_arn = aws_lb_listener.web-lb-listener.arn
#   priority     = 500

#   action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.static_tg.arn
#   }

#   condition {
#     path_pattern {
#       values = ["/static*"]
#     }
#   }
# }