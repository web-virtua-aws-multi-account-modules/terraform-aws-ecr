output "ecr" {
  description = "ECR"
  value       = aws_ecr_repository.create_ecr
}

output "lifecycle_policy" {
  description = "ECR lifecycle policy"
  value       = try(aws_ecr_lifecycle_policy.create_lifecycle_policy[0], null)
}

output "repository_policy" {
  description = "ECR repository access policy"
  value       = try(aws_ecr_repository_policy.create_repository_policy[0], null)
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
