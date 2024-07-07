resource "aws_instance" "example_instance" {
  count = 1
  ami = lookup(var.AMIs, var.AWS_REGION)
  instance_type = "t2.micro"

  tags = {
    Name = "demoinstance-${count.index}"
  }
  
  security_groups = "${var.security_group}"
}