resource "aws_costoptimizationhub_enrollment_status" "this" {
  count = var.enable_cost_recommendations_export ? 1 : 0

  include_member_accounts = true
}
