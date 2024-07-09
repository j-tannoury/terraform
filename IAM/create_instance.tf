resource "aws_key_pair" "levelup_key"{
  key_name = "levelup_key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "example_instance" {
  ami = lookup(var.AMIs, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name = aws_key_pair.levelup_key.key_name
  availability_zone = "us-east-1a"
  iam_instance_profile = aws_iam_instance_profile.s3-levelupbucket-role-instanceprofile.name
  tags = {
    Name = "demoinstance"
  }
  
}

output "public_ip" {
  value = aws_instance.example_instance.public_ip
}