variable "name_prefix" {
  type = string
}

variable "lambda_role_name" {
  type        = string
  description = "Execution role name della Lambda che dovrà leggere il secret"
}

variable "lambda_function_name" {
  type        = string
  description = "Nome della Lambda per il log-masking"
}

variable "log_retention_days" {
  type    = number
  default = 14
}

variable "create_log_group" {
  type        = bool
  default     = true
  description = "Se true, crea esplicitamente il log group della Lambda (evita race con creazione automatica)"
}
