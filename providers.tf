terraform {
  cloud {
    organization = "HashiCorp_TFC_Automation_Demo"
    workspaces {
      name = "deploy-eks-secrets-engine-vault"
      //tags = ["networking"]
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.93.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.36.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = ">= 4.7.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
  assume_role {
    role_arn    = var.role_arn
    external_id = "terraform_agent_dev"
  }
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

provider "vault" {
  // skip_child_token must be explicitly set to true as HCP Terraform manages the token lifecycle
  skip_child_token = true
  address          = var.tfc_vault_dynamic_credentials.default.address
  namespace        = var.tfc_vault_dynamic_credentials.default.namespace

  auth_login_token_file {
    filename = var.tfc_vault_dynamic_credentials.default.token_filename
  }
}
