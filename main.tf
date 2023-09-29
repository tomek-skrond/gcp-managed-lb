terraform {
  required_version = ">= 0.12"
  required_providers {}
  
  backend "gcs" {
    bucket = "lbstate"
    prefix = "terraform/state"
  }
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