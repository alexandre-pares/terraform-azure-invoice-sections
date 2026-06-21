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
  source = "../.."

  billing_account_id = var.billing_account_id
  billing_profile_id = var.billing_profile_id

  sections = local.sections
}
