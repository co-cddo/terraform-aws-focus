resource "aws_iam_service_linked_role" "bcm_data_exports" {
  count = var.create_cost_recommendations_service_linked_role ? 1 : 0

  aws_service_name = "bcm-data-exports.amazonaws.com"
}

resource "time_sleep" "service_linked_role" {
  create_duration = "10s"

  depends_on = [
    aws_iam_service_linked_role.bcm_data_exports,
  ]
}

data "aws_iam_policy_document" "replicator_assume" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"

      identifiers = [
        "s3.amazonaws.com",
      ]
    }
  }
}

resource "aws_iam_role" "this" {
  name               = "GDSCloudConsumption"
  path               = "/service-role/"
  assume_role_policy = data.aws_iam_policy_document.replicator_assume.json
}

data "aws_iam_policy_document" "replicator" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetObjectVersionForReplication",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectVersionTagging",
    ]

    resources = [
      format("%s/*", aws_s3_bucket.this.arn),
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
      "s3:GetReplicationConfiguration",
    ]

    resources = [
      aws_s3_bucket.this.arn,
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:ReplicateObject",
      "s3:ReplicateDelete",
      "s3:ReplicateTags",
    ]

    resources = [
      format("arn:aws:s3:::%s/*", var.destination_bucket_name),
    ]
  }
}

resource "aws_iam_role_policy" "replicator" {
  name   = "Replication"
  role   = aws_iam_role.this.id
  policy = data.aws_iam_policy_document.replicator.json
}
