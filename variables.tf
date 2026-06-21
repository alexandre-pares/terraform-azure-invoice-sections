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

variable "sections" {
  description = <<DESCRIPTION
  Map of invoice sections:

  - `name` - Name of the invoice section
  - `display Name` - (Optional) Display name of Invoice Section
  - `tags` - (Optional) Map of Tags

  Examples:

  ```hcl
  {
    it_platform_alz = {
      name = "86-3133-it-platform-alz"
    }
    hr_lms_license = {
      name = "02-520-hr-lsm-license"
    }
    hr_lms = {
      name = "02-3133-hr-lms"
    }
  }
  ```

  DESCRIPTION

  type = map(object({
    name         = string
    display_name = optional(string)
    tags         = optional(map(string))
  }))

  validation {
    condition = alltrue([
      for k, v in var.sections : can(regex("^[a-zA-Z0-9-_]{1,128}$", v.name))
    ])
    error_message = "Invoice section name must be between 1 and 128 characters long and contain only letters, numbers, hyphens, or underscores."
  }
}
