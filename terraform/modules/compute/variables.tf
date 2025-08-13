variable "name_prefix" {
  type = string
}

variable "lambda_arch" {
  type    = string
  default = "x86_64"
}
variable "codedeploy_alarm_enabled" {
  type    = bool
  default = false
}

variable "codedeploy_alarm_names" {
  type    = list(string)
  default = []
}

variable "image_uri" {
  type = string
}

