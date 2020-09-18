output "lambda_version" {
  description = "The selected version of the Lambda code"
  value       = module.lambda_version.target_version
}

output "lambda_version_info" {
  description = "all information about the selected version of the Lambda code"
  value       = module.lambda_version.version_info
}

output "result" {
  description = "String result of Lambda execution"
  value       = module.lambda_invocation_result.stdout
}

output "secret_arn" {
  description = "ARN of the secret containing the password"
  value       = aws_secretsmanager_secret.this.arn
}

output "secret_name" {
  description = "Name of the secret containing the password"
  value       = aws_secretsmanager_secret.this.name
}
