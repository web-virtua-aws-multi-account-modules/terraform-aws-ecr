resource "aws_ecr_repository" "create_ecr" {
  name                 = var.registry_name
  image_tag_mutability = var.mutability_type
  force_delete         = var.force_delete

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  encryption_configuration {
    encryption_type = var.encryption_type
    kms_key         = var.kms_arn
  }

  tags = merge(var.tags, {
    "tf-type" = "ecr"
    "Name"    = var.registry_name
    "tf-ou"   = var.ou_name
  })
}

resource "aws_ecr_lifecycle_policy" "create_lifecycle_policy" {
  count      = var.lifecycle_policy != null ? 1 : 0
  repository = aws_ecr_repository.create_ecr.name
  policy     = var.lifecycle_policy
}

resource "aws_ecr_repository_policy" "create_repository_policy" {
  count      = var.repository_policy != null ? 1 : 0
  repository = aws_ecr_repository.create_ecr.name
  policy     = var.repository_policy
}
