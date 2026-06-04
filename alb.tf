resource "aws_lb" "instance_alb" {
  name               = "docker-app-alb"
  internal           = false
  ip_address_type    = "ipv4"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.vpc_sg_main.id]

  subnet_mapping {
    subnet_id = aws_subnet.aws_vpc_subnet.id
  }

  subnet_mapping {
    subnet_id = aws_subnet.aws_vpc_subnet_b.id
  }
}

resource "aws_lb_listener" "instance_front_alb" {
  load_balancer_arn = aws_lb.instance_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.instance_target_group.arn

    forward {
      target_group {
        arn = aws_lb_target_group.instance_target_group.arn
      }
    }
  }
}

resource "aws_lb_target_group" "instance_target_group" {
  name        = "instance-target-group"
  port        = "80"
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.aws_instance_vpc.id
}

resource "aws_lb_target_group_attachment" "alb_target_attachment" {
  target_group_arn = aws_lb_target_group.instance_target_group.arn
  target_id        = aws_instance.terraform_aws_instance.id
  port             = "8080"
}
