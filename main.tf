module "kube_secrets_backend" {
  source   = "/Users/simon.elliott/Documents/Code/New_Structure/Terraform_Modules/Vault/terraform-vault-kubernetes-secret-backend"
  for_each = toset(split(", ", var.namespaces))

  namespace          = each.value
  description        = "kubernetes secrets backend for ${each.value}"
  kubernetes_host    = data.aws_eks_cluster.cluster.endpoint
  kubernetes_ca_cert = data.aws_eks_cluster.cluster.certificate_authority[0].data
  token              = data.aws_eks_cluster_auth.cluster.token
}



