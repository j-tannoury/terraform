resource "aws_key_pair" "levelup_key"{
  key_name = "levelup_key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "example_instance" {
  ami = lookup(var.AMIs, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name = aws_key_pair.levelup_key.key_name
  availability_zone = "us-east-1a"

  tags = {
    Name = "demoinstance"
  }
  
}

# Create EBS
resource "aws_ebs_volume" "ebs-volume-1" {
  availability_zone = "us-east-1a"
  size = 50
  type = "gp2"

  tags = {
    Name = "Secondary volume Disk"
  }
}

#attach EBS volume with AWS instance
resource "aws_volume_attachment" "aws-volume-1-attachment" {
  device_name = "/dev/xvdh"
  volume_id = aws_ebs_volume.ebs-volume-1.id
  instance_id = aws_instance.example_instance.id
}