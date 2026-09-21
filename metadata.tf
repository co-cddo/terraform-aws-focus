data "modtm_module_source" "this" {
  module_path = path.module
}

resource "aws_s3_object" "metadata" {
  bucket       = aws_s3_bucket.this.id
  key          = format("%s/metadata/metadata.json", local.account_id)
  content_type = "application/json"

  content = jsonencode({
    module_version                     = data.modtm_module_source.this.module_version
    module_source                      = data.modtm_module_source.this.module_source
    account_id                         = local.account_id
    enable_carbon_export               = var.enable_carbon_export
    enable_cost_recommendations_export = var.enable_cost_recommendations_export
  })

  depends_on = [
    aws_s3_bucket_replication_configuration.this,
  ]
}
