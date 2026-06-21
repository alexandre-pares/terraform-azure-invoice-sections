# Microsoft.Billing billingAccounts/billingProfiles/invoiceSections
# Learn more: https://learn.microsoft.com/en-us/azure/templates/microsoft.billing/billingaccounts/billingprofiles/invoicesections
resource "azapi_resource" "this" {
  for_each = var.sections

  type      = "Microsoft.Billing/billingAccounts/billingProfiles/invoiceSections@2024-04-01"
  name      = each.value.name
  parent_id = "/providers/Microsoft.Billing/billingAccounts/${var.billing_account_id}/billingProfiles/${var.billing_profile_id}"

  body = {
    properties = {
      displayName = coalesce(each.value.display_name, each.value.name)
      state       = coalesce(each.value.state, "Active")
    }
    tags = try(each.value.tags, null)
  }
}
