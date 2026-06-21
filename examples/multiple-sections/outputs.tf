output "invoice_sections" {
  description = <<DESCRIPTION

  Informations about the invoice section created in the module.

  DESCRIPTION

  value = module.invoice_sections.invoice_sections
}
