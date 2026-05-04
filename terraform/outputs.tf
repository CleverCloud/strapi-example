output "app_id" {
  description = "Application ID"
  value       = clevercloud_nodejs.strapi_app.id
}

output "app_default_vhosts" {
  description = "Application vhosts (*.cleverapps.io)"
  value       = clevercloud_nodejs.strapi_app.vhosts
}

output "app_url" {
  description = "Application URL"
  value       = length(clevercloud_nodejs.strapi_app.vhosts) > 0 ? "https://${one(clevercloud_nodejs.strapi_app.vhosts).fqdn}" : "Application being created"
}

output "database_id" {
  description = "PostgreSQL database ID"
  value       = clevercloud_postgresql.strapi_db.id
}

output "cellar_id" {
  description = "Cellar addon ID"
  value       = clevercloud_cellar.strapi_storage.id
}

output "cellar_bucket_id" {
  description = "Cellar bucket ID"
  value       = clevercloud_cellar_bucket.strapi_bucket.id
}

output "cellar_host" {
  description = "Cellar S3 host"
  value       = clevercloud_cellar.strapi_storage.host
}

output "cellar_key_id" {
  description = "Cellar Access Key ID"
  value       = clevercloud_cellar.strapi_storage.key_id
  sensitive   = true
}

output "cellar_key_secret" {
  description = "Cellar Secret Access Key"
  value       = clevercloud_cellar.strapi_storage.key_secret
  sensitive   = true
}

output "custom_domain_instructions" {
  description = "Instructions to add a custom domain"
  value       = var.custom_domain != "" ? "To add the domain ${var.custom_domain}, use: clever domain add ${var.custom_domain} --app ${clevercloud_nodejs.strapi_app.id}" : "No custom domain configured"
}
