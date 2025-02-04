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
