data "modtm_module_source" "this" {
  module_path = path.module
}

resource "aws_s3_object" "manifest" {
  bucket       = aws_s3_bucket.this.id
  key          = format("%s/manifest.json", local.account_id)
  content_type = "application/json"

  content = jsonencode({
    module_source  = data.modtm_module_source.this.module_source
    module_version = data.modtm_module_source.this.module_version
    configuration = {
      enable_focus_export                = true
      enable_carbon_export               = var.enable_carbon_export
      enable_cost_recommendations_export = var.enable_cost_recommendations_export
    }
  })

  depends_on = [
    aws_s3_bucket_replication_configuration.this,
  ]
}
