# terraform-aws-focus

A Terraform module for exporting:
* [FOCUS](https://focus.finops.org/) (FinOps Open Cost and Usage Specification).
* [Cost Optimisation recommendations](https://aws.amazon.com/blogs/aws-cloud-financial-management/generate-your-cost-optimization-reports-with-data-exports-for-cost-optimization-hub/).
* [Carbon Emissions data](https://aws.amazon.com/blogs/aws-cloud-financial-management/export-and-visualize-carbon-emissions-data-from-your-aws-accounts/).
to an S3 bucket, which replicates securely to Government Digital Services (GDS), over the AWS internal network.

The encrypted (SSE-S3) S3 bucket has the following:
* Bucket Policy which grants permissions to the BCM Data Exports service to write the report data files.
* Lifecycle Policy which removes non-current versions after 1 day. Latest versions are kept for 7 days before being removed.
* Service Linked IAM role allowing the S3 service to read objects from the bucket and replicate them to the destination bucket.
* Replication rule that uses the IAM role above to do the replication. The IAM role is authorised on the destination GDS S3 bucket to allow the sender to only replicate the data, and to an isolated drop-zone.

## Review
[@jonodrew](https://github.com/jonodrew) reviewed this package on 2025-02-13 and found no significant concerns. The package:

1. Creates a new S3 bucket for storing cost exports
2. Sets up replication to a central S3 bucket
3. Sets up AWS cost exports to create a daily report and store it in the bucket created in step 1
4. Sets up a cleanup on the bucket to remove old / deleted files after 7 days

The Bucket's Role has permissions to replicate any Object that is put in it, so hosting teams must ensure that nothing is accidentally placed there. 

If this library is deployed through a continuous deployment (CD) pipeline, deploying teams should thoroughly check any changes to this codebase before they are deployed. 

## Features

* Creates AWS Billing & Cost Management data exports for FOCUS, Carbon Emission and Cost Optimisation.
* Creates an S3 Bucket storing export data in the AWS account.
* Configures replication to a GDS managed destination S3 Bucket.
* Creates a service-link IAM Role for use in replication to GDS.
* Enables versioning and encryption for data at rest within the S3 bucket.
* Configures an S3 Bucket Lifecycle Policy to ensure data is not retained longer than neccesary.

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
| [aws_bcmdataexports_export.carbon](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/bcmdataexports_export) | resource |
| [aws_bcmdataexports_export.focus](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/bcmdataexports_export) | resource |
| [aws_bcmdataexports_export.recommendations](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/bcmdataexports_export) | resource |
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
| <a name="input_enable_carbon_export"></a> [enable\_carbon\_export](#input\_enable\_carbon\_export) | Enables the collection of carbon footprint report | `bool` | `true` | no |
| <a name="input_enable_cost_recommendations_export"></a> [enable\_cost\_recommendations\_export](#input\_enable\_cost\_recommendations\_export) | Enables the collection of cost recommendations report | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources created by this module. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | The ARN of the bucket created to store reports before replicating to GDS |
| <a name="output_replication_role_arn"></a> [replication\_role\_arn](#output\_replication\_role\_arn) | The ARN of the role used to replicate data from the source account to the destination account |
