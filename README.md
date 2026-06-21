# Invoice Sections Terraform module for Microsoft Azure

Terraform Module to manage Azure invoice sections.
Create invoice sections to organize costs of multiples subscriptions directly in the invoice (per application, team, environment, etc.).

Supports MCA and MCA-E billing accounts with direct billing.

Learn more: https://learn.microsoft.com/en-us/azure/cost-management-billing/manage/mca-section-invoice

## Usage

You should first create the invoice sections with the current module and then create or attach the subscription to it.
For the later part I recommend to use [the AVM for Subscription Vending](https://github.com/Azure/terraform-azure-avm-ptn-alz-sub-vending) and set the parameter [`subscription_billing_scope`](https://github.com/Azure/terraform-azure-avm-ptn-alz-sub-vending#-subscription_billing_scope) to the invoice section resource id.

### Create a single invoice section

```hcl
module "invoice_section" {
  source  = "alexandre-pares/invoice-sections/azure"
  version = "1.0.1"

  billing_account_id = var.billing_account_id
  billing_profile_id = var.billing_profile_id

  sections = {
    it-devops-sandbox = {
      name         = "it-devops-sandbox"
      display_name = "IT DevOps Sandbox"
      tags = {
        department  = "it"
        team        = "devops"
        cost_center = "86-3133"
      }
    }
  }
}
```

You can the retrieve the invoice section resource id from the module's outputs:

```bash
# Invoice section resource_id (e.g. `/providers/Microsoft.Billing/billingAccounts/00000000-0000-5000-3000-000000000000:00000000-0000-4000-0000-000000000000_2019-05-31/BillingProfiles/0000-0000-000-000/invoiceSections/it-devops-sandbox`)
module.invoice_section.invoice_sections["it-devops-sandbox"].resource_id
```

## Requirements

Write access over one of the following resource:

- Billing account
- Billing profile

Learn more: https://learn.microsoft.com/en-us/azure/cost-management-billing/manage/understand-mca-roles#manage-invoice-sections-for-billing-profile

## Common errors

### Resource already exists

```bash
╷
│ Error: Resource already exists
│
│   with module.invoice_sections.azapi_resource.this["hr_lms"],
│   on ../../main.tf line 3, in resource "azapi_resource" "this":
│    3: resource "azapi_resource" "this" {
│
│ a resource with the ID
│ "/providers/Microsoft.Billing/billingAccounts/00000000-0000-5000-3000-000000000000:00000000-0000-4000-0000-000000000000_2019-05-31/billingProfiles/0000-0000-000-000/invoiceSections/02-3133-hr-lms"
│ already exists - to be managed via Terraform this resource needs to be imported into the State. Please
│ see the resource documentation for "azapi_resource" for more information
╵
```

This can happen if you try to use an invoice section name that was previouly deleted. Deleted invoice sections are still queriable and will return `state` to `Deleted`.

To fix this issue you will need to change the name of your new invoice section

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.8 |
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | ~> 2.10 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azapi"></a> [azapi](#provider\_azapi) | ~> 2.10 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azapi_resource.this](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_billing_account_id"></a> [billing\_account\_id](#input\_billing\_account\_id) | Id of the MCA billing account.<br/><br/>  Id can be found via the Azure Portal (portal.azure.com) via "Cost Management + Billing > Billing scopes > Select your MCA > Settings > Properties > Billing account id".<br/><br/>  Examples:<br/><br/>  - `00000000-0000-5000-3000-000000000000:00000000-0000-4000-0000-000000000000_2019-05-31` | `string` | n/a | yes |
| <a name="input_billing_profile_id"></a> [billing\_profile\_id](#input\_billing\_profile\_id) | Id of the billing profile attached to `var.billing_account_id`.<br/><br/>  Id can be found via the Azure Portal (portal.azure.com) via "Cost Management + Billing > Billing scopes > Select your MCA > Billing > Billing profiles > Select your Billing profile > Settings > Properties > Billing profile ID".<br/><br/>  Examples:<br/><br/>  - `0000-0000-000-000`<br/>  - `00000000-0000-4000-0000-000000000000` | `string` | n/a | yes |
| <a name="input_sections"></a> [sections](#input\_sections) | Map of invoice sections:<br/><br/>  - `name`          - Name of the Invoice Section<br/>  - `display Name`  - (Optional) Display name of the Invoice Section<br/>  - `tags`          - (Optional) Map of Tags<br/><br/>  Examples:<pre>hcl<br/>  {<br/>    it_platform_alz = {<br/>      name = "86-3133-it-platform-alz"<br/>    }<br/>    hr_lms_license = {<br/>      name = "02-520-hr-lms-license"<br/>    }<br/>    hr_lms = {<br/>      name = "02-3133-hr-lms"<br/>    }<br/>  }</pre> | <pre>map(object({<br/>    name         = string<br/>    display_name = optional(string)<br/>    tags         = optional(map(string))<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_invoice_sections"></a> [invoice\_sections](#output\_invoice\_sections) | Informations about the invoice sections created in the module.<br/><br/>  The map value contains the following attributes:<br/>  - `name` - Name<br/>  - `display_name` - Display Name<br/>  - `tags` - Map of Tags<br/>  - `id` - The unique Id<br/>  - `resource_id` - The full id, including billing account and billing profile<br/>  - `resource` - The full azapi\_resource |
<!-- END_TF_DOCS -->
