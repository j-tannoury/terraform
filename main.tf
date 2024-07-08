data "aws_availability_zones" "az" {}

data "aws_ami" "latest-ubuntu" {
  most_recent = true
  owners = ["099720109477"]

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "example_instance" {
#   count = 1
  ami = data.aws_ami.latest-ubuntu.id
  instance_type = "t2.micro"
  availability_zone = data.aws_availability_zones.az.names[1]

  tags = {
    Name = "demoinstance"
  }
  provisioner "local-exec" {
    command = "echo ${aws_instance.example_instance.private_ip} >> my_private_ip.txt"
}
}
output "public_ip" {
    value = aws_instance.example_instance.public_ip
}

