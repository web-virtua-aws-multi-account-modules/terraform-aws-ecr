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

resource "aws_ecr_lifecycle_policy" "create_police" {
  count      = var.policy != null ? 1 : 0
  repository = aws_ecr_repository.create_ecr.name
  policy     = var.policy
}
