variable "project" {
  type = string
}

variable "env" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "alarm_email" {
  type = string
}

variable "lambda_arch" {
  type    = string
  default = "x86_64"
}

variable "image_uri" {
  type = string
}
