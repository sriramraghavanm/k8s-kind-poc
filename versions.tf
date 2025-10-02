terraform {
  required_version = ">= 1.7.0"

  # Uncomment and configure for remote state (recommended when collaborating)
  # backend "s3" {
  #   bucket         = "my-terraform-state-bucket"
  #   key            = "local-kind/terraform.tfstate"
  #   region         = "us-east-1"
  #   encrypt        = true
  #   dynamodb_table = "terraform-locks"
  # }

  backend "local" {
    # Explicit local backend storing state under state/
    path = "state/terraform.tfstate"
  }

  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = "~> 0.5"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.28"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.13"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
  }
}
