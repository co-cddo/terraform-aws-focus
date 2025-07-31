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
