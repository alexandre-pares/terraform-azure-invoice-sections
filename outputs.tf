output "invoice_sections" {
  description = <<DESCRIPTION

  Informations about the invoice sections created in the module.

  The map value contains the following attributes:
  - `name` - Name
  - `display_name` - Display Name
  - `tags` - Map of Tags
  - `id` - The unique Id
  - `resource_id` - The full id, including billing account and billing profile
  - `resource` - The full azapi_resource

  DESCRIPTION

  value = {
    for k, v in azapi_resource.this :
    k => {
      name         = v.name
      display_name = v.body.properties.displayName
      tags         = try(v.output.tags, null)
      id           = v.output.properties.systemId
      resource_id  = v.id
      resource     = v
    }
  }
}
