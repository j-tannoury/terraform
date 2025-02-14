resource "aws_elb" "levelup-elb" {
  name = "levelup-elb"
  subnets = [aws_subnet.levelupvpc-public-1.id, aws_subnet.levelupvpc-public-2.id]
  security_groups = [aws_security_group.levelup-elb-securitygroup.id]

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 2
    target = "HTTP:80/"
    interval = 30
  }
  cross_zone_load_balancing = true
  connection_draining = true
  connection_draining_timeout = 400
  tags = {
    Name = "levelup-elb"
  }
}

resource "aws_security_group" "levelup-elb-securitygroup" {
  vpc_id = aws_vpc.levelup_vpc.id
  name = "levelup-elb-securitygroup"
  description = "123"

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "levelup-elb-sg"
  }
}

resource "aws_security_group" "levelup-instance" {
  vpc_id = aws_vpc.levelup_vpc.id
  name = "levelup-instance"
  description = "123"

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = [aws_security_group.levelup-elb-securitygroup.id]
  }
  tags = {
    Name = "levelup-elb-instance"
  }
}