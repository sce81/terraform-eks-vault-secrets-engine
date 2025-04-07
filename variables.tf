variable "cluster_name" {
  type        = string
  description = "Name of EKS Cluster to apply configuration to"
  default     = "demo-public"
}
variable "organization" {
  default     = "HashiCorp_TFC_Automation_Demo"
  type        = string
  description = "workspace to deploy to"
}
variable "namespaces" {
  type        = string
  description = "Namespaces to deploy to cluster"
  default     = "default"
}

variable "role_arn" {
  default     = null
  description = "AWS IAM Role to assume for this deployment"
}

variable "tfc_vault_dynamic_credentials" {
  description = "Object containing Vault dynamic credentials configuration"
  type = object({
    default = object({
      token_filename = string
      address        = string
      namespace      = string
      ca_cert_file   = string
    })
    aliases = map(object({
      token_filename = string
      address        = string
      namespace      = string
      ca_cert_file   = string
    }))
  })
}
