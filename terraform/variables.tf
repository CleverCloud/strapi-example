# ===========================
# CLEVER CLOUD CREDENTIALS
# ===========================
variable "clevercloud_token" {
  description = "Clever Cloud OAuth Token (or use CC_OAUTH_TOKEN environment variable)"
  type        = string
  sensitive   = true
  default     = ""
}

variable "clevercloud_secret" {
  description = "Clever Cloud OAuth Secret (or use CC_OAUTH_SECRET environment variable)"
  type        = string
  sensitive   = true
  default     = ""
}

# ===========================
# ORGANISATION (REQUIRED)
# ===========================
variable "organisation_id" {
  description = "Clever Cloud organisation ID (user_xxx for Personal Space, orga_xxx for organisation)"
  type        = string
}

# ===========================
# APPLICATION
# ===========================
variable "app_name" {
  description = "Strapi application name"
  type        = string
  default     = "strapi-app"
}

variable "region" {
  description = "Deployment region (par, mtl, rbx, sgp, syd, wsw)"
  type        = string
  default     = "par"
}

variable "instance_type" {
  description = "Instance type (XS, S, M, L, XL, XXL)"
  type        = string
  default     = "XS"
}

variable "build_instance_type" {
  description = "Build instance type (XS, S, M, L, XL, XXL)"
  type        = string
  default     = "M"
}

variable "min_instance_count" {
  description = "Minimum number of instances"
  type        = number
  default     = 1
}

variable "max_instance_count" {
  description = "Maximum number of instances"
  type        = number
  default     = 1
}

# ===========================
# DATABASE
# ===========================
variable "postgres_plan" {
  description = "PostgreSQL plan (dev, xs_sml, s, m, l, xl, xxl_2)"
  type        = string
  default     = "xs_sml"
  
  validation {
    condition     = can(regex("^(dev|xs_sml|s|m|l|xl|xxl_2)$", var.postgres_plan))
    error_message = "PostgreSQL plan must be: dev, xs_sml, s, m, l, xl, or xxl_2"
  }
}

# ===========================
# OBJECT STORAGE
# ===========================
variable "cellar_bucket_name" {
  description = "Cellar bucket name for storing Strapi media"
  type        = string
}

# ===========================
# DOMAIN
# ===========================
variable "custom_domain" {
  description = "Custom domain (to be added manually after deployment)"
  type        = string
  default     = ""
}

# ===========================
# FRONTEND CONFIGURATION
# ===========================
variable "FRONTEND_URL" {
  description = "Frontend URL (e.g., https://mysite.com)"
  type        = string
  default     = ""
}

# ===========================
# SMTP CONFIGURATION
# ===========================
variable "SMTP_FROM" {
  description = "Sender email address (e.g., noreply@mydomain.com)"
  type        = string
  default     = ""
}

variable "SMTP_HOST" {
  description = "SMTP host (e.g., smtp.gmail.com)"
  type        = string
  default     = ""
}

variable "SMTP_PORT" {
  description = "SMTP port (e.g., 587 for TLS, 465 for SSL)"
  type        = string
  default     = "587"
}

variable "SMTP_USERNAME" {
  description = "SMTP username"
  type        = string
  sensitive   = true
  default     = ""
}

variable "SMTP_PASSWORD" {
  description = "SMTP password"
  type        = string
  sensitive   = true
  default     = ""
}

# ===========================
# STRAPI SECRETS
# ===========================
variable "admin_jwt_secret" {
  description = "Admin JWT Secret (generate with: openssl rand -hex 32)"
  type        = string
  sensitive   = true
}

variable "api_token_salt" {
  description = "API Token Salt (generate with: openssl rand -hex 32)"
  type        = string
  sensitive   = true
}

variable "app_keys" {
  description = "App Keys - 4 values separated by commas (generate 4 times: openssl rand -hex 32)"
  type        = string
  sensitive   = true
}

variable "jwt_secret" {
  description = "JWT Secret (generate with: openssl rand -hex 32)"
  type        = string
  sensitive   = true
}

variable "transfer_token_salt" {
  description = "Transfer Token Salt (generate with: openssl rand -hex 32)"
  type        = string
  sensitive   = true
}

# ===========================
# GIT DEPLOYMENT
# ===========================
variable "git_repository_url" {
  description = "Git repository URL (e.g., https://github.com/username/repo.git)"
  type        = string
}

variable "git_branch" {
  description = "Git branch to deploy"
  type        = string
  default     = "main"
}

variable "github_token" {
  description = "GitHub token for private repository (optional)"
  type        = string
  sensitive   = true
  default     = ""
}
