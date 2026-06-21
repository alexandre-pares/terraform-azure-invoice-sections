variable "billing_account_id" {
  description = <<DESCRIPTION
  Id of the MCA billing account.

  Id can be found via the Azure Portal (portal.azure.com) via "Cost Management + Billing > Billing scopes > Select your MCA > Settings > Properties > Billing account id".

  Examples:

  - `00000000-0000-5000-3000-000000000000:00000000-0000-4000-0000-000000000000_2019-05-31`

  DESCRIPTION

  type     = string
  nullable = false
}

variable "billing_profile_id" {
  description = <<DESCRIPTION
  Id of the billing profile attached to `var.billing_account_id`.

  Id can be found via the Azure Portal (portal.azure.com) via "Cost Management + Billing > Billing scopes > Select your MCA > Billing > Billing profiles > Select your Billing profile > Settings > Properties > Billing profile ID".

  Examples:

  - `0000-0000-000-000`
  - `00000000-0000-4000-0000-000000000000`

  DESCRIPTION

  type     = string
  nullable = false
}
