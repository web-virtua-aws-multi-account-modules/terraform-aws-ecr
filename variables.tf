variable "registry_name" {
  description = "Registry Name"
  type        = string
}

variable "policy" {
  description = "Policy File"
  type        = any
  default     = null
}

variable "mutability_type" {
  description = "Registry can be MUTABLE or IMMUTABLE"
  type        = string
  default     = "IMMUTABLE"
}

variable "force_delete" {
  description = "If true will delete the repository and images"
  type        = bool
  default     = false
}

variable "scan_on_push" {
  description = "If true will delete the repository and images"
  type        = bool
  default     = false
}

variable "encryption_type" {
  description = "Encryption type can be AES256 or KMS"
  type        = string
  default     = "AES256"
}

variable "kms_arn" {
  description = "The ARN of the KMS to use encryption type is KMS"
  type        = string
  default     = null
}

variable "ou_name" {
  description = "Organization unit name"
  type        = string
  default     = "no"
}

variable "tags" {
  description = "Tags to bucket"
  type        = map(any)
  default     = {}
}
