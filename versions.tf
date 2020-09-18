terraform {
  required_version = "~> 0.12.28"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }

    null = {
      source  = "hashicorp/null"
      version = "~> 2.1"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 2.3"
    }
  }
}
