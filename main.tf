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
# resource "aws_key_pair" "key_pair"{
#   key_name = "access_key"
#   public_key = file(var.PATH_TO_PUBLIC_KEY)
# }

resource "aws_instance" "example_instance" {
  count = 1
  ami = data.aws_ami.latest-ubuntu.id
  instance_type = "t2.micro"
  # key_name = aws_key_pair.key_pair.key_name
  availability_zone = data.aws_availability_zones.az.names[1]

  tags = {
    Name = "demoinstance-${count.index}"
  }
  # provisioner "file" {
  #   source = "installNginx.sh"
  #   destination = "/tmp/installNginx.sh"
  # }
  # provisioner "remote-exec" {
  #   inline = [
  #     "chmod +x /tmp/installNginx.sh",
  #     "sudo sed -i -e 's/\r$//' /tmp/installNginx.sh",
  #     "sudo /tmp/installNginx.sh"
  #   ]
  # }
  # connection {
  #   host = coalesce(self.public_ip, self.private_ip)
  #   type = "ssh"
  #   user = var.INSTANCE_USERNAME
  #   private_key = file(var.PATH_TO_PRIVATE_KEY)
  # }
  # security_groups = "${var.security_group}"
}