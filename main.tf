module "kube_secrets_backend" {
  source   = "git@github.com:sce81/terraform-vault-kubernetes-secrets-engine.git"
  for_each = toset(split(", ", var.namespaces))

  namespace          = each.value
  description        = "kubernetes secrets backend for ${each.value}"
  kubernetes_host    = data.aws_eks_cluster.cluster.endpoint
  kubernetes_ca_cert = data.aws_eks_cluster.cluster.certificate_authority[0].data
  token              = data.aws_eks_cluster_auth.cluster.token
}



