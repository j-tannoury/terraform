resource "aws_security_group" "allow-levelup-ssh" {
  vpc_id = aws_vpc.levelup_vpc.id
  name = "allow-levelup-ssh"
  description = "security group that allows ssh connection"

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1" // all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] // not good practice
  }

  tags = {
    Name = "allow-levelup-ssh"
  }
}