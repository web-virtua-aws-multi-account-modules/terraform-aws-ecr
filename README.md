# AWS ECR Repository for multiples accounts and regions Terraform module
* This module simplifies creating and configuring ECR repositories across multiple accounts and regions on AWS

* Is possible use this module with one region using the standard profile or multi account and regions using multiple profiles setting in the modules.

## Actions necessary to use this module:

* Create file versions.tf with the exemple code below:
```hcl
terraform {
  required_version = ">= 1.3.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.9"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 2.0"
    }
  }
}
```

* Criate file provider.tf with the exemple code below:
```hcl
provider "aws" {
  alias   = "alias_profile_a"
  region  = "us-east-1"
  profile = "my-profile"
}

provider "aws" {
  alias   = "alias_profile_b"
  region  = "us-east-2"
  profile = "my-profile"
}
```


## Features enabled for ECR repository configurations in this module:

- Lifecycle Policy
- Repository Policy
- Scanning Configuration
- Encryption Configuration
- Image Mutability
- Force Delete

## Usage exemples

### Repository with versioning with AES256 encryption

```hcl
module "registry_test" {
  source        = "web-virtua-aws-multi-account-modules/ecr/aws"
  registry_name = "tf-registry-test"
  mutability_type = "IMMUTABLE"
  force_delete    = false
  scan_on_push    = true
  ou_name         = var.ous.sso
  
  repository_policy = local.repo_policy
  lifecycle_policy  = local.lifecycle_policy

  providers = {
    aws = aws.luby_sso
  }
}
```

### Repository with versioning with KMS encryption

```hcl
module "registry_test" {
  source        = "web-virtua-aws-multi-account-modules/ecr/aws"
  registry_name = "tf-registry-test"
  mutability_type = "IMMUTABLE"
  force_delete    = false
  scan_on_push    = true
  ou_name         = var.ous.sso
  
  repository_policy = local.repo_policy
  lifecycle_policy  = local.lifecycle_policy
  encryption_type = "KMS"
  kms_arn = "arn:aws:kms:us-east-':123456789012:key/32aaa...d24eb2"

  providers = {
    aws = aws.luby_sso
  }
}
```

## Variables

| Name | Type | Default | Required | Description | Options |
|------|-------------|------|---------|:--------:|:--------|
| registry_name | `string` | `-` | yes | Name to ECR Registry | `-` |
| mutability_type | `string` | `IMMUTABLE` | no | Mutability type | `*`MUTABLE<br> `*`IMMUTABLE<br> |
| force_delete | `bool` | `false` | no | Force delete images | `*`false <br> `*`true |
| scan_on_push | `bool` | `true` | no | Indicates whether images are scanned after being pushed | `*`false <br> `*`true |
| repository_policy | `any` | `null` | no | Repository access policy | `-` |
| lifecycle_policy | `any` | `null` | no | Lifecycle rules policy | `-` |
| encryption_type | `string` | `AES256` | no | Encryption type | `*`AES256<br> `*`KMS<br> |
| kms_arn | `string` | `null` | no | ARN of the KMS key | `-` |
| ou_name | `string` | `no` | no | Organization unit name | `-` |
| tags | `map(any)` | `{}` | no | Tags to repository | `-` |


## Resources

| Name | Type |
|------|------|
| [aws_ecr_repository.create_ecr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_lifecycle_policy.create_lifecycle_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_repository_policy.create_repository_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy) | resource |

## Outputs

| Name | Description |
|------|-------------|
| `ecr` | All informations of the registry |
| `ecr_arn` | The ARN of the registry |
| `lifecycle_policy` | The lifecycle policy for images |
| `repository_policy` | The repository access policy |
| `ecr_registry_id` | The ECR registry ID |
| `ecr_repository_url` | The ECR registry URL |
