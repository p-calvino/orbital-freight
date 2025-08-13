variable "name_prefix" {
  type = string

}
variable "api_id" {
  type = string
}

variable "alarm_email" {
  description = "Email per sottoscrizione SNS degli allarmi"
  type        = string
  validation {
    condition     = can(regex("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$", var.alarm_email))
    error_message = "Fornisci un indirizzo email valido."
  }
}

variable "aws_region" {
  type    = string
  default = "eu-central-1"
}
