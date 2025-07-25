moved {
  from = aws_bcmdataexports_export.this
  to   = aws_bcmdataexports_export.focus
}

resource "aws_bcmdataexports_export" "focus" {
  export {
    name = "gds-focus-v1"

    data_query {
      query_statement = format("SELECT %s FROM FOCUS_1_0_AWS", join(", ", local.focus_export_fields))

      table_configurations = {
        FOCUS_1_0_AWS = {}
      }
    }

    destination_configurations {
      s3_destination {
        s3_bucket = aws_s3_bucket.this.bucket
        s3_region = aws_s3_bucket.this.region
        s3_prefix = local.account_id

        s3_output_configurations {
          overwrite   = "OVERWRITE_REPORT"
          format      = "PARQUET"
          compression = "PARQUET"
          output_type = "CUSTOM"
        }
      }
    }

    refresh_cadence {
      frequency = "SYNCHRONOUS"
    }
  }
}

resource "aws_bcmdataexports_export" "carbon" {
  export {
    name = "gds-carbon-v1"

    data_query {
      query_statement = format("SELECT %s FROM CARBON_EMISSIONS", join(", ", local.carbon_export_fields))

      table_configurations = {
        CARBON_EMISSIONS = {}
      }
    }

    destination_configurations {
      s3_destination {
        s3_bucket = aws_s3_bucket.this.bucket
        s3_region = aws_s3_bucket.this.region
        s3_prefix = local.account_id

        s3_output_configurations {
          overwrite   = "OVERWRITE_REPORT"
          format      = "PARQUET"
          compression = "PARQUET"
          output_type = "CUSTOM"
        }
      }
    }

    refresh_cadence {
      frequency = "SYNCHRONOUS"
    }
  }
}

resource "aws_bcmdataexports_export" "recommendations" {
  export {
    name = "gds-recommendations-v1"

    data_query {
      query_statement = format("SELECT %s FROM COST_OPTIMIZATION_RECOMMENDATIONS", join(", ", local.recommendations_export_fields))

      table_configurations = {
        COST_OPTIMIZATION_RECOMMENDATIONS = {
          INCLUDE_ALL_RECOMMENDATIONS = "TRUE"
          FILTER                      = jsonencode({})
        }
      }
    }

    destination_configurations {
      s3_destination {
        s3_bucket = aws_s3_bucket.this.bucket
        s3_region = aws_s3_bucket.this.region
        s3_prefix = local.account_id

        s3_output_configurations {
          overwrite   = "OVERWRITE_REPORT"
          format      = "PARQUET"
          compression = "PARQUET"
          output_type = "CUSTOM"
        }
      }
    }

    refresh_cadence {
      frequency = "SYNCHRONOUS"
    }
  }
}