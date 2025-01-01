variable "name" {}

variable "randomize_name" {
  default = false
}

variable "rg" {
  type = object({
    name     = string
    location = string
  })
}

variable "sku" {
  default  = "Basic"
  nullable = false
}

variable "admin_enabled" {
  default  = true
  nullable = false
}

variable "tags" {
  default  = {}
  nullable = false
}

variable "role_assignments" {
  type = map(object({
    principal_id                     = string
    role_definition_name             = optional(string, "AcrPull")
    skip_service_principal_aad_check = optional(bool, true)
  }))
  default  = {}
  nullable = false
}