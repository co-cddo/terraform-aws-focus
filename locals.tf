locals {
  account_id = data.aws_caller_identity.this.account_id

  default_bucket_name = format("gds-export-%s", local.account_id)
  bucket_name         = coalesce(var.bucket_name, local.default_bucket_name)

  export_fields = [
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
}
