terraform {
  required_version = ">= 0.12"
  required_providers {}

  backend "gcs" {}
  # Add these attrs in command: 
    # bucket = var.bucket_name
    # prefix = "terraform/state"
    # terraform init \
    # -backend-config="bucket=${TF_VAR_bucket_name}" \
    # -backend-config="prefix=terraform/state"
}

provider "google" {
  credentials = var.credential_file
  project     = var.project
  region      = var.region
  zone        = var.zone
}

provider "google-beta" {
  credentials = var.credential_file
  project     = var.project
  region      = var.region
  zone        = var.zone
}