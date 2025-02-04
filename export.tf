resource "aws_bcmdataexports_export" "this" {
  export {
    name = "gds-focus-v1"

    data_query {
      query_statement = format("SELECT %s FROM FOCUS_1_0_AWS", join(", ", local.export_fields))

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
          overwrite   = "CREATE_NEW_REPORT"
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
