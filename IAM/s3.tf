resource "aws_s3_bucket" "levelup-s3bucket" {
  bucket = "levelup-bucket-joseph"
  acl = "private"

  tags = {
    Name = "levelup-bucket-joseph"
  }
}

