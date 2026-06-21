module "invoice_section" {
  source = "../.."

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
