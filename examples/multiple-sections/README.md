# Create multiple invoice sections

This example creates multiple invoice sections.

![Multiple Invoice Sections](../../assets/multiple-sections.png)

## Usage

Set the following variables:

- `billing_account_id` - Id of the MCA billing account.
- `billing_profile_id` - Id of the billing profile attached to `var.billing_account_id`.

Then run the following commands to deploy the export:

```bash
# Init Terraform
terraform init

# Plan changes
terraform plan

# Apply
terraform apply
```

## Main code

```hcl
locals {
  sections = {
    it_platform_alz = {
      name         = "86-3133-it-platform-alz"
      display_name = "IT Platform Azure Landing Zone"
      tags = {
        department  = "it"
        team        = "platform"
        cost_center = "86-3133"
      }
    }
    hr_lms_license = {
      name = "02-520-hr-lms-license"
    }
    hr_lms = {
      name = "02-3133-hr-lms"
    }
  }
}


module "invoice_sections" {
  source  = "alexandre-pares/invoice-sections/azure"
  version = "1.0.1"

  billing_account_id = var.billing_account_id
  billing_profile_id = var.billing_profile_id

  sections = local.sections
}
```

You can then retrieve the invoice section id from Terraform module's output:

```bash
# Invoice section Id (e.g. `00000000-0000-4000-0000-000000000000`)
module.invoice_section.invoice_sections["it-devops-sandbox"].id
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.8 |
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | ~> 2.10 |

## Providers

No providers.

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_invoice_sections"></a> [invoice\_sections](#module\_invoice\_sections) | ../.. | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_billing_account_id"></a> [billing\_account\_id](#input\_billing\_account\_id) | Id of the MCA billing account.<br/><br/>  Id can be found via the Azure Portal (portal.azure.com) via "Cost Management + Billing > Billing scopes > Select your MCA > Settings > Properties > Billing account id".<br/><br/>  Examples:<br/><br/>  - `00000000-0000-5000-3000-000000000000:00000000-0000-4000-0000-000000000000_2019-05-31` | `string` | n/a | yes |
| <a name="input_billing_profile_id"></a> [billing\_profile\_id](#input\_billing\_profile\_id) | Id of the billing profile attached to `var.billing_account_id`.<br/><br/>  Id can be found via the Azure Portal (portal.azure.com) via "Cost Management + Billing > Billing scopes > Select your MCA > Billing > Billing profiles > Select your Billing profile > Settings > Properties > Billing profile ID".<br/><br/>  Examples:<br/><br/>  - `0000-0000-000-000`<br/>  - `00000000-0000-4000-0000-000000000000` | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_invoice_sections"></a> [invoice\_sections](#output\_invoice\_sections) | Informations about the invoice section created in the module. |
<!-- END_TF_DOCS -->
