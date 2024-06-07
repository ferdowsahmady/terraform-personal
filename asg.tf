locals {
  resource_name = "ziyotek"
}

resource "aws_launch_template" "ziyotek-template" {
  name_prefix   = "${local.resource_name}-template"
  image_id      = data.aws_ami.example.image_id
  instance_type = "t2.micro"
   key_name      = "ferro-key"
  instance_initiated_shutdown_behavior = "terminate"


  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 8
      volume_type = "gp2"
    }
  }

  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    security_groups             = [aws_security_group.ziyo_security_group.id]
  }

  user_data = filebase64("efs-web.sh")

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${local.resource_name}-instance"
    }
  }

  tags = {
    Environment = "dev"
    Project     = "${local.resource_name}-template"
  }
}

resource "aws_autoscaling_group" "ziyotek-asg" {
  name             = "${local.resource_name}-asg"
  max_size         = 3
  min_size         = 0
  desired_capacity = 0
  health_check_grace_period        = 30
  force_delete     = false

  launch_template {
    id      = aws_launch_template.ziyotek-template.id
    version = "$Latest"

  }
  vpc_zone_identifier  = [aws_subnet.ziyo_subnet_public.id, aws_subnet.ziyo_subnet_public_2.id]
}

    
resource "aws_lb_target_group" "ziyoket-tg" {
  name     = "${local.resource_name}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.ziyo_vpc.id

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 10
    path                = "/"
    port                = "traffic-port"
    matcher             = "200-300"
  }
}

# Create a new ALB Target Group attachment
resource "aws_autoscaling_attachment" "ziyotek-asg-attachment" {
  autoscaling_group_name = aws_autoscaling_group.ziyotek-asg.id
  lb_target_group_arn    = aws_lb_target_group.ziyoket-tg.arn
}

resource "aws_lb" "ziyotek-alb" {
  name               = "${local.resource_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ziyo_security_group.id]
  subnets            = [aws_subnet.ziyo_subnet_public.id, aws_subnet.ziyo_subnet_public_2.id]

  enable_deletion_protection = false

}
resource "aws_lb_listener" "ziyotek-alb-listener" {
  load_balancer_arn = aws_lb.ziyotek-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ziyoket-tg.arn
  }
}

resource "aws_lb_listener_rule" "ziyotek" {
  listener_arn = aws_lb_listener.ziyotek-alb-listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ziyoket-tg.arn
  }

  condition {
    path_pattern {
      values = ["/web*"]
    }
  }
}