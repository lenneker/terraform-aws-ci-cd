
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
}


resource "aws_security_group" "lb_sg" {
  name        = "${var.environment}"
  vpc_id      = aws_vpc.vpc.id

    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


  ingress {
    from_port        = 3000
    to_port          = 3000
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Main"
  }
}