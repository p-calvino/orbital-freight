variable "name_prefix" {
  description = "Prefisso per nominare le risorse del progetto (es. orbital-freight-dev)."
  type        = string
}

variable "allowed_subs" {
  description = <<EOT
Pattern consentiti per il claim 'sub' del token OIDC GitHub.
Esempi:
  - "repo:OWNER/REPO:ref:refs/heads/main"
  - "repo:OWNER/REPO:ref:refs/tags/*"
  - "repo:OWNER/REPO:pull_request"
  - "repo:OWNER/REPO:environment:Production"
EOT
  type        = list(string)
}

variable "admin" {
  description = "Se true allega AdministratorAccess al ruolo (POC/emergenze). Se false usa least-privilege."
  type        = bool
  default     = false
}

variable "create_oidc_provider" {
  description = "Crea l'OIDC provider GitHub."
  type        = bool
  default     = true
}

variable "existing_oidc_provider_arn" {
  description = "ARN di un OIDC provider GitHub già presente."
  type        = string
  default     = null
}

variable "github_oidc_thumbprints" {
  description = "Thumbprints del certificato root per il provider OIDC GitHub."
  type        = list(string)
  default = [
    "6938fd4d98bab03faadb97b34396831e3780aea1",
    "1c58a3a8518e8759bf075b76b750d4f2df264fcd"
  ]
}

variable "max_session_duration" {
  description = "Durata massima della sessione STS in secondi (default 3600s)."
  type        = number
  default     = 3600
}

variable "tags" {
  description = "Mappa tag comuni da applicare alle risorse del modulo."
  type        = map(string)
  default     = {}
}

