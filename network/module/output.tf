output "public_instance_id" {
  value = ["${aws_instance.levelup_instance.public_ip}"]
}