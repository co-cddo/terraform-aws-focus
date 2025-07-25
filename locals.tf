locals {
  account_id = data.aws_caller_identity.this.account_id

  default_bucket_name = format("gds-export-%s", local.account_id)
  bucket_name         = coalesce(var.bucket_name, local.default_bucket_name)

  carbon_toggle = toset(
    var.enable_carbon_export ? ["enabled"] : []
  )

  cost_recommendations_toggle = toset(
    var.enable_cost_recommendations_export ? ["enabled"] : []
  )

  focus_export_fields = [
    "AvailabilityZone",
    "BilledCost",
    "BillingCurrency",
    "BillingPeriodEnd",
    "BillingPeriodStart",
    "ChargeCategory",
    "ChargeClass",
    "ChargeFrequency",
    "ChargePeriodEnd",
    "ChargePeriodStart",
    "CommitmentDiscountCategory",
    "CommitmentDiscountId",
    "CommitmentDiscountStatus",
    "CommitmentDiscountType",
    "ConsumedQuantity",
    "ConsumedUnit",
    "ContractedCost",
    "ContractedUnitPrice",
    "EffectiveCost",
    "InvoiceIssuerName",
    "ListCost",
    "ListUnitPrice",
    "PricingCategory",
    "PricingQuantity",
    "PricingUnit",
    "ProviderName",
    "PublisherName",
    "RegionName",
    "ResourceType",
    "ServiceCategory",
    "ServiceName",
    "SkuId",
    "SkuPriceId",
  ]

  carbon_export_fields = [
    "last_refresh_timestamp",
    "location",
    "model_version",
    "payer_account_id",
    "product_code",
    "region_code",
    "total_lbm_emissions_unit",
    "total_lbm_emissions_value",
    "total_mbm_emissions_unit",
    "total_mbm_emissions_value",
    "usage_account_id",
    "usage_period_end",
    "usage_period_start",
  ]

  recommendations_export_fields = [
    "account_id",
    "action_type",
    "currency_code",
    "current_resource_details",
    "current_resource_summary",
    "current_resource_type",
    "estimated_monthly_cost_after_discount",
    "estimated_monthly_cost_before_discount",
    "estimated_monthly_savings_after_discount",
    "estimated_monthly_savings_before_discount",
    "estimated_savings_percentage_after_discount",
    "estimated_savings_percentage_before_discount",
    "implementation_effort",
    "last_refresh_timestamp",
    "recommendation_id",
    "recommendation_lookback_period_in_days",
    "recommendation_source",
    "recommended_resource_details",
    "recommended_resource_summary",
    "recommended_resource_type",
    "region",
    "resource_arn",
    "restart_needed",
    "rollback_possible",
    "tags",
  ]
}
