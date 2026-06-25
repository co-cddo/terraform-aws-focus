variable "enable_carbon_export" {
  type        = bool
  default     = true
  description = "Enables the collection of carbon footprint report"
}

variable "enable_cost_recommendations_export" {
  type        = bool
  default     = true
  description = "Enables the collection of cost recommendations report"
}

variable "create_cost_recommendations_service_linked_role" {
  type        = bool
  default     = false
  description = "Enables the creation of the required service-linked role for data exports to access cost optimisation hub"
}

variable "bucket_name" {
  type        = string
  default     = null
  description = "The name of the S3 bucket to be created to store reports before replication. If omitted it will create one for you."
}

variable "bucket_tags" {
  type        = map(string)
  default     = {}
  description = "Map of tags to be associated with the reporting bucket"
}

variable "destination_account_id" {
  type        = string
  description = "The account ID of the destination S3 bucket where reports will be replicated to. This will be provided as part of the onboarding process."
}

variable "destination_bucket_name" {
  type        = string
  description = "The name of the destination S3 bucket where reports will be replicated to. This will be provided as part of the onboarding process."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to all resources created by this module."
}

variable "additional_policy_statements" {
  type = list(object({
    sid       = string
    effect    = string
    actions   = list(string)
    resources = list(string)
    principals = object({
      type        = string
      identifiers = list(string)
    })
    conditions = list(object({
      test     = string
      variable = string
      values   = list(string)
    }))
  }))
  default     = []
  description = "Additional IAM policy statements to include in the S3 bucket policy. All fields are required — use empty string for sid if not needed, empty list for conditions if none required. Statements are appended to the default BCM grant and cannot replace or remove it. Use this instead of creating a separate aws_s3_bucket_policy resource."
}

variable "enforce_secure_defaults" {
  type        = bool
  default     = false
  description = "When true, adds hardening deny statements to the bucket policy (e.g. DenyNonSSLRequests). Defaults to false for backward compatibility. Will default to true in a future major release."
}
