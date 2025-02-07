resource "aws_s3_bucket" "this" {
  bucket = local.bucket_name
  tags   = merge(var.tags, var.bucket_tags)
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    id     = "Cleanup"
    status = "Enabled"

    expiration {
      days                         = 0
      expired_object_delete_marker = true
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }

    noncurrent_version_expiration {
      noncurrent_days = 7
    }
  }
}

data "aws_iam_policy_document" "bucket" {
  statement {
    principals {
      type = "Service"
      identifiers = [
        "bcm-data-exports.amazonaws.com",
        "billingreports.amazonaws.com",
      ]
    }

    actions = [
      "s3:PutObject",
      "s3:GetBucketPolicy",
    ]

    resources = [
      aws_s3_bucket.this.arn,
      format("%s/*", aws_s3_bucket.this.arn),
    ]

    condition {
      test     = "StringLike"
      variable = "aws:SourceAccount"

      values = [
        local.account_id,
      ]
    }

    condition {
      test     = "StringLike"
      variable = "aws:SourceArn"

      values = [
        format("arn:aws:cur:us-east-1:%s:definition/*", local.account_id),
        format("arn:aws:bcm-data-exports:us-east-1:%s:export/*", local.account_id),
      ]
    }
  }
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.bucket.json
}

resource "aws_s3_bucket_replication_configuration" "this" {
  bucket = aws_s3_bucket.this.id
  role   = aws_iam_role.this.arn

  rule {
    id     = "GDSDataExport"
    status = "Enabled"

    destination {
      bucket = format("arn:aws:s3:::%s", var.destination_bucket_name)
    }

    filter {
      prefix = format("%s/%s/data/", local.account_id, aws_bcmdataexports_export.this.export[0].name)
    }

    delete_marker_replication {
      status = "Disabled"
    }
  }

  depends_on = [
    aws_s3_bucket_versioning.this,
  ]
}
