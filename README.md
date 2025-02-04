# terraform-aws-focus

A Terraform module for setting up a FOCUS (FinOps Open Cost and Usage Specification) export within an AWS account. This module configures an export destination bucket in AWS, enables replication to the Government Digital Services (GDS), and applies necessary policies for secure data transfer.

## Features

* Creates an S3 bucket for FOCUS exports in the AWS account
* Configures replication to a GDS-managed destination bucket
* Applies IAM policies for secure access
* Enables versioning and encryption
* Optionally configures lifecycle policies

## Prerequisites

Terraform 1.0+

AWS CLI configured with appropriate permissions

An IAM role with sufficient permissions to create and manage S3 buckets and replication rules, and AWS BCM data exports.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_bcmdataexports_export.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/bcmdataexports_export) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.replicator](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_lifecycle_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_replication_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_replication_configuration) | resource |
| [aws_s3_bucket_versioning.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.replicator](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.replicator_assume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The name of the S3 bucket to be created to store reports before replication. If omitted it will create one for you. | `string` | `null` | no |
| <a name="input_bucket_tags"></a> [bucket\_tags](#input\_bucket\_tags) | Map of tags to be associated with the reporting bucket | `map(string)` | `{}` | no |
| <a name="input_destination_account_id"></a> [destination\_account\_id](#input\_destination\_account\_id) | The account ID of the destination S3 bucket where reports will be replicated to. This will be provided as part of the onboarding process. | `string` | n/a | yes |
| <a name="input_destination_bucket_name"></a> [destination\_bucket\_name](#input\_destination\_bucket\_name) | The name of the destination S3 bucket where reports will be replicated to. This will be provided as part of the onboarding process. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources created by this module. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | The ARN of the bucket created to store reports before replicating to GDS |
| <a name="output_replication_role_arn"></a> [replication\_role\_arn](#output\_replication\_role\_arn) | The ARN of the role used to replicate data from the source account to the destination account |
