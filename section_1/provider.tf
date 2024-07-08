provider "aws"{
    version = "3.53.0"
    region = "${var.AWS_REGION}"
    profile = "${var.AWS_PROFILE}"
}