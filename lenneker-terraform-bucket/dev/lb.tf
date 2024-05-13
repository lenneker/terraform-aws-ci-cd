resource "aws_lb" "app_lb" {
  name               = "${var.environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [aws_subnet.public.id]

  enable_deletion_protection = true

  tags = {
    Environment = "${var.environment}"
  }
}


resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = "3000"
  //protocol          = "HTTPS"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

resource "aws_lb_target_group" "target_group" {
  name     = "${var.environment}"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
  target_type = "ip"
}
