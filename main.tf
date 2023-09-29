terraform {
  required_version = ">= 0.12"
  required_providers {}
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