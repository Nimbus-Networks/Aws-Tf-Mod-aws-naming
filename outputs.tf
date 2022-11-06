output "unique-seed" {
  value = coalesce(var.unique-seed, local.random_safe_generation)
}

output "validation" {
  value = local.validation
}
output "analysis_services_server" {
  value       = local.az.analysis_services_server
  description = "Analysis Services Server"
}

output "api_management" {
  value       = local.az.api_management
  description = "Api Management"
}
