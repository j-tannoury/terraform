variable "AWS_PROFILE" {
  default = "terraform"
}
variable "AWS_REGION" {
  default = "us-east-1"
}
variable "security_group"{
    type = list(string)
    default = ["sg-24076","sg-24077","sg-24078"]
}

variable "AMIs" {
  type = map(string)
  default = {
    "us-east-1":"ami-0b0ea68c435eb488d"
    "us-east-2":"ami-05803413c51f242b7"
    "us-west-1":"ami-0454207e5367abf01"
    "us-west-2":"ami-0688ba7eeeeefe3cd"
  }
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "access_key"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "access_key.pub"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}