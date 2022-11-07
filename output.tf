output "ecr" {
  description = "ECR"
  value       = aws_ecr_repository.create_ecr
}

output "ecr_policy" {
  description = "ECR policy"
  value       = aws_ecr_lifecycle_policy.create_police
}

output "ecr_arn" {
  description = "ECR ARN"
  value       = aws_ecr_repository.create_ecr.arn
}

output "ecr_registry_id" {
  description = "ECR registry ID"
  value       = aws_ecr_repository.create_ecr.registry_id
}

output "ecr_repository_url" {
  description = "ECR repository url"
  value       = aws_ecr_repository.create_ecr.repository_url
}
