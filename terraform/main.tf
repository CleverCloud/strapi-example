terraform {
  required_providers {
    clevercloud = {
      source  = "clevercloud/clevercloud"
      version = "~> 1.9.0"
    }
  }
}

provider "clevercloud" {
  token        = var.clevercloud_token
  secret       = var.clevercloud_secret
  organisation = var.organisation_id
}

# Cellar Add-on (S3-compatible object storage)
resource "clevercloud_cellar" "strapi_storage" {
  name = "${var.app_name}-storage"
}

# Cellar Bucket
resource "clevercloud_cellar_bucket" "strapi_bucket" {
  cellar_id = clevercloud_cellar.strapi_storage.id
  id        = var.cellar_bucket_name
}

# PostgreSQL Add-on
resource "clevercloud_postgresql" "strapi_db" {
  name   = "${var.app_name}-db"
  region = var.region
  plan   = var.postgres_plan
}

# Node.js Application for Strapi with automatic deployment
resource "clevercloud_nodejs" "strapi_app" {
  name   = var.app_name
  region = var.region

  min_instance_count = var.min_instance_count
  max_instance_count = var.max_instance_count
  
  smallest_flavor = var.instance_type
  biggest_flavor  = var.instance_type
  build_flavor    = var.build_instance_type

  dependencies = [
    clevercloud_postgresql.strapi_db.id,
    clevercloud_cellar.strapi_storage.id
  ]

  environment = merge(
    {
      ADMIN_JWT_SECRET     = var.admin_jwt_secret
      API_TOKEN_SALT       = var.api_token_salt
      APP_KEYS             = var.app_keys
      CC_NODE_BUILD_TOOL   = "yarn"
      CELLAR_BUCKET        = var.cellar_bucket_name
      DATABASE_CLIENT      = "postgres"
      HOST                 = "0.0.0.0"
      JWT_SECRET           = var.jwt_secret
      NODE_ENV             = "production"
      TRANSFER_TOKEN_SALT  = var.transfer_token_salt
      CELLAR_ADDON_REGION  = "fr-par"
    },
    var.FRONTEND_URL != "" ? { FRONTEND_URL = var.FRONTEND_URL } : {},
    var.SMTP_HOST != "" ? {
      SMTP_FROM     = var.SMTP_FROM
      SMTP_HOST     = var.SMTP_HOST
      SMTP_PORT     = var.SMTP_PORT
      SMTP_USERNAME = var.SMTP_USERNAME
      SMTP_PASSWORD = var.SMTP_PASSWORD
    } : {}
  )

  # Automatic deployment from GitHub
  deployment {
    repository = var.git_repository_url
    
    # For private repositories, add:
    # authentication_basic = "<username>:<github_personal_access_token>"
    
    # Deploy a specific branch
    commit = "refs/heads/main"  # or "refs/heads/master"
  }
}
