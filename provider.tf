variable "credentials" {
  type = string
}

provider "google" {
  credentials = var.credentials
  project     = "vargolabs"
}

terraform {
  backend "remote" {
    organization = "TFTMM-Dev"

    workspaces {
      name = "google-cloud-demo"
    }
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.35"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 2.3"
    }
  }
}
