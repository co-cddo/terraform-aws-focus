output "bucket_arn" {
  value       = aws_s3_bucket.this.arn
  description = "The ARN of the bucket created to store reports before replicating to GDS"
}

output "replication_role_arn" {
  value       = aws_iam_role.this.arn
  description = "The ARN of the role used to replicate data from the source account to the destination account"
}
